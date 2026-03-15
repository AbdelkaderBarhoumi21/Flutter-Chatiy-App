import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_message_own_tile.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_message_tile.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_date_label.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ListView(
      children: const [
        CustomDateLabel(label: 'Yesterday'),
        CustomChatScreenMessageTile(
          message: 'Hello, how are you?',
          messageDate: '12:00 PM',
        ),
        CustomChatScreenMessageOwnTile(
          message: 'I am fine, thank you',
          messageDate: '12:02 PM',
        ),
      ],
    ),
  );
}
