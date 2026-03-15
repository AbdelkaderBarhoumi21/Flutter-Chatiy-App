import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';

class CustomChatScreenAppBarTitle extends StatelessWidget {
  const CustomChatScreenAppBarTitle({required this.messageModel, super.key});
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Avatar.small(url: messageModel.profilePicture),
      const SizedBox(width: 16),

      Expanded(
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            Text(
              messageModel.senderName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 2),
            const Text(
              'Online now',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
