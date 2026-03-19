import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_message_own_tile.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_message_tile.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_date_label.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({required this.messages, super.key});
  final List<Message> messages;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ListView.separated(
      itemCount: messages.length + 1,
      separatorBuilder: (context, index) {
        if (index == messages.length - 1) {
          return CustomDateLabel(dateTime: messages[index].createdAt);
        }
        if (messages.length == 1) {
          return const SizedBox.shrink();
        } else if (index >= messages.length - 1) {
          return const SizedBox.shrink();
        } else if (index <= messages.length - 1) {
          final message = messages[index];
          final nextMessage = messages[index + 1];
          if (!Jiffy.parseFromDateTime(message.createdAt.toLocal()).isSame(
            Jiffy.parseFromDateTime(nextMessage.createdAt.toLocal()),
            unit: Unit.day,
          )) {
            return CustomDateLabel(dateTime: nextMessage.createdAt);
          } else {
            return const SizedBox.shrink();
          }
        } else {
          return const SizedBox.shrink();
        }
      },
      itemBuilder: (context, index) {
        if (index < messages.length) {
          final message = messages[index];
          if (message.user?.id == context.currentUser?.id) {
            return CustomChatScreenMessageOwnTile(message: message);
          } else {
            return CustomChatScreenMessageTile(message: message);
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    ),
  );
}
