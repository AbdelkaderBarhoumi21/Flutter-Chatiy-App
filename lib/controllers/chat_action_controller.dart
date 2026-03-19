import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Controller for managing chat action bar business logic
/// Handles message sending and typing indicators
class ChatActionController {
  ChatActionController({required this.channel});

  final Channel channel;
  final TextEditingController textController = TextEditingController();

  /// Send a message to the channel
  Future<void> sendMessage() async {
    if (textController.text.isNotEmpty) {
      await channel.sendMessage(Message(text: textController.text));
      textController.clear();
    }
  }

  /// Handle typing indicator - sends keystroke event to channel
  void handleTyping() {
    channel.keyStroke();
  }

  /// Clean up resources
  void dispose() {
    textController.dispose();
  }
}
