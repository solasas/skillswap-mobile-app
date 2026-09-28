import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/conversation.dart';
import '../models/message.dart';
import 'core_providers.dart';

final conversationsProvider = FutureProvider.autoDispose<List<Conversation>>((ref) {
  return ref.watch(messagesRepositoryProvider).getConversations();
});

final conversationMessagesProvider =
    FutureProvider.autoDispose.family<List<Message>, int>((ref, otherUserId) {
  return ref.watch(messagesRepositoryProvider).getConversation(otherUserId);
});

final unreadCountProvider = FutureProvider.autoDispose<int>((ref) {
  return ref.watch(messagesRepositoryProvider).getUnreadCount();
});

class ChatThreadNotifier extends StateNotifier<List<Message>> {
  ChatThreadNotifier({
    required this.historyMessages,
    required this.otherUserId,
  }) : super(historyMessages);

  final List<Message> historyMessages;
  final int otherUserId;

  void addMessage(Message message) {
    if (message.sender.id == otherUserId || message.receiver.id == otherUserId) {
      final existingIndex = state.indexWhere((m) => m.id == message.id);
      if (existingIndex >= 0) {
        state = [
          ...state.sublist(0, existingIndex),
          message,
          ...state.sublist(existingIndex + 1),
        ];
      } else {
        state = [...state, message];
      }
    }
  }
}

final chatThreadProvider = StateNotifierProvider.family<ChatThreadNotifier, List<Message>, int>(
  (ref, otherUserId) {
    final historyAsync = ref.watch(conversationMessagesProvider(otherUserId));
    final messages = historyAsync.maybeWhen(
      data: (data) => data,
      orElse: () => <Message>[],
    );
    return ChatThreadNotifier(
      historyMessages: messages,
      otherUserId: otherUserId,
    );
  },
);
