import 'dart:convert';
import 'dart:async';

import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../models/message.dart';
import '../storage/secure_storage_service.dart';
import 'api_constants.dart';

class ChatSocketService {
  ChatSocketService();

  StompClient? _client;
  late StreamController<Message> _messageStream;
  late StreamController<String> _errorStream;
  bool _isConnected = false;
  bool _isConnecting = false;

  Stream<Message> get messages => _messageStream.stream;
  Stream<String> get errors => _errorStream.stream;
  bool get isConnected => _isConnected;

  Future<void> connect() async {
    if (_isConnecting || _isConnected) return;
    _isConnecting = true;

    _messageStream = StreamController<Message>.broadcast();
    _errorStream = StreamController<String>.broadcast();

    try {
      final token = await SecureStorageService.instance.readToken();
      if (token == null || token.isEmpty) {
        _errorStream.add('No authentication token available');
        _isConnecting = false;
        return;
      }

      final wsUrl = _buildWebSocketUrl();

      final config = StompConfig(
        url: wsUrl,
        onConnect: _onConnect,
        onWebSocketError: _onWebSocketError,
        onDisconnect: _onDisconnect,
        stompConnectHeaders: {
          'Authorization': 'Bearer $token',
        },
        heartbeatOutgoing: const Duration(seconds: 10),
        heartbeatIncoming: const Duration(seconds: 10),
      );

      _client = StompClient(config: config);
      _client!.activate();
    } catch (e) {
      _errorStream.add('Failed to initialize WebSocket: $e');
      _isConnecting = false;
      _isConnected = false;
    }
  }

  void _onConnect(StompFrame frame) {
    _isConnected = true;
    _isConnecting = false;

    // Subscribe to incoming messages
    _client!.subscribe(
      destination: '/user/queue/messages',
      callback: _onMessageReceived,
    );

    // Subscribe to errors
    _client!.subscribe(
      destination: '/user/queue/errors',
      callback: _onErrorReceived,
    );
  }

  void _onWebSocketError(dynamic error) {
    _errorStream.add('WebSocket error: $error');
    _isConnected = false;
  }

  void _onDisconnect(StompFrame frame) {
    _isConnected = false;
    _isConnecting = false;
  }

  void _onMessageReceived(StompFrame frame) {
    try {
      if (frame.body == null) return;
      final json = jsonDecode(frame.body!) as Map<String, dynamic>;
      final message = Message.fromJson(json);
      _messageStream.add(message);
    } catch (e) {
      _errorStream.add('Failed to parse message: $e');
    }
  }

  void _onErrorReceived(StompFrame frame) {
    if (frame.body != null) {
      _errorStream.add(frame.body!);
    }
  }

  Future<void> sendMessage({
    required int receiverId,
    required String content,
  }) async {
    if (!_isConnected) {
      _errorStream.add('Not connected to chat server');
      return;
    }

    try {
      final body = jsonEncode({
        'receiverId': receiverId,
        'content': content,
      });

      _client!.send(
        destination: '/app/chat.send',
        body: body,
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      _errorStream.add('Failed to send message: $e');
    }
  }

  Future<void> disconnect() async {
    if (_client != null) {
      _client!.deactivate();
    }
    _isConnected = false;
    _isConnecting = false;
    await _messageStream.close();
    await _errorStream.close();
  }

  String _buildWebSocketUrl() {
    final baseUrl = ApiConstants.baseUrl;
    // Extract host:port from http://host:port/api
    final uri = Uri.parse(baseUrl);
    return 'ws://${uri.host}:${uri.port}/ws';
  }
}
