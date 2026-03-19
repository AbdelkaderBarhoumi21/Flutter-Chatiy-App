import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/views/chat/widgets/custom_chat_screen_message_own_tile.dart';
import 'package:flutter_chatiy_app/views/chat/widgets/custom_chat_screen_message_tile.dart';
import 'package:flutter_chatiy_app/views/chat/widgets/custom_date_label.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({required this.messages, super.key});
  final List<Message> messages;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final bool isFirstInGroup =
            index == messages.length - 1 ||
            !Jiffy.parseFromDateTime(message.createdAt.toLocal()).isSame(
              Jiffy.parseFromDateTime(messages[index + 1].createdAt.toLocal()),
              unit: Unit.day,
            );

        return Column(
          children: [
            if (isFirstInGroup) CustomDateLabel(dateTime: message.createdAt),
            if (message.user?.id == context.currentUser?.id)
              CustomChatScreenMessageOwnTile(message: message)
            else
              CustomChatScreenMessageTile(message: message),
          ],
        );
      },
    ),
  );
}
