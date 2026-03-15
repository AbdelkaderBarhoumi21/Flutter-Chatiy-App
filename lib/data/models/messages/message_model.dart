import 'package:flutter/foundation.dart' show immutable;

@immutable
class MessageModel {
  const MessageModel({
    required this.senderName,
    required this.message,
    required this.messageDate,
    required this.dateMessage,
    required this.profilePicture,
  });
  final String senderName;
  final String message;
  final DateTime messageDate;
  final String dateMessage;
  final String profilePicture;
}
