import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/network/api_exception.dart';
import '../../models/message.dart';
import '../../providers/auth_provider.dart';
import '../../providers/core_providers.dart';
import '../../providers/messages_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.otherUserId});

  final int otherUserId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late ScrollController _scrollController;
  final _messageController = TextEditingController();
  bool _sending = false;
  String? _otherUserName;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Mark messages as read by fetching conversation
    // (backend marks them as read as a side effect)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(unreadCountProvider);
    });
    _setupSocket();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    // Don't disconnect socket here as it may be used by other chat screens
    // The socket service will handle its own lifecycle
    super.dispose();
  }

  Future<void> _setupSocket() async {
    final socketService = ref.read(chatSocketServiceProvider);

    if (!socketService.isConnected) {
      await socketService.connect();
    }

    // Listen to incoming messages
    socketService.messages.listen(
      (message) {
        if (mounted) {
          ref.read(chatThreadProvider(widget.otherUserId).notifier).addMessage(message);
          _scrollToBottom();
        }
      },
      onError: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Socket error: $error')),
          );
        }
      },
    );

    // Listen to errors
    socketService.errors.listen(
      (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          );
        }
      },
      onError: (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error stream error: $error')),
          );
        }
      },
    );
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.microtask(() {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Future<void> _sendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    setState(() => _sending = true);
    _messageController.clear();

    try {
      final message = await ref
          .read(messagesRepositoryProvider)
          .sendMessage(receiverId: widget.otherUserId, content: content);

      // Optimistically add message to the thread (socket may still be echoing)
      if (mounted) {
        ref.read(chatThreadProvider(widget.otherUserId).notifier).addMessage(message);
        _scrollToBottom();
      }
    } on ApiException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatThreadProvider(widget.otherUserId));
    final myId = ref.watch(authProvider).userId;

    return Scaffold(
      appBar: AppBar(
        title: Text(_otherUserName ?? 'Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.isEmpty
                ? const Center(
                    child: Text('Start a conversation...'),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: messagesAsync.length,
                    itemBuilder: (context, index) {
                      final message = messagesAsync[index];
                      final isMine = message.sender.id == myId;
                      _otherUserName ??= isMine ? message.receiver.name : message.sender.name;
                      return _MessageBubble(message: message, isMine: isMine);
                    },
                  ),
          ),
          _MessageComposer(
            messageController: _messageController,
            onSend: _sendMessage,
            sending: _sending,
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.isMine,
  });

  final Message message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isMine
                      ? theme.colorScheme.primary
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.08),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isMine ? theme.colorScheme.onPrimary : null,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      DateFormat('HH:mm').format(message.createdAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isMine
                            ? theme.colorScheme.onPrimary.withValues(alpha: 0.6)
                            : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({
    required this.messageController,
    required this.onSend,
    required this.sending,
  });

  final TextEditingController messageController;
  final VoidCallback onSend;
  final bool sending;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.2),
          ),
        ),
      ),
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Message...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                isDense: true,
              ),
              enabled: !sending,
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: sending ? null : (_) => onSend(),
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: sending
                  ? theme.colorScheme.primary.withValues(alpha: 0.2)
                  : theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: sending ? null : onSend,
              icon: sending
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation(
                          theme.colorScheme.onPrimary.withValues(alpha: 0.6),
                        ),
                      ),
                    )
                  : Icon(
                      Icons.send,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
