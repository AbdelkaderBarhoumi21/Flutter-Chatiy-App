import 'dart:async';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Controller for managing chat screen business logic
/// Separates business logic from UI components following MVC pattern
class ChatController {
  ChatController({required this.channel});

  final Channel channel;
  StreamSubscription<int>? _unreadCountSubscription;

  /// Initialize the controller and set up listeners
  void init() {
    _unreadCountSubscription = channel.state!.unreadCountStream.listen(_handleUnreadCount);
  }

  /// Handle unread count changes - mark messages as read when entering chat
  Future<void> _handleUnreadCount(int count) async {
    if (count > 0) {
      await channel.markRead();
    }
  }

  /// Clean up resources when controller is no longer needed
  void dispose() {
    _unreadCountSubscription?.cancel();
  }
}
