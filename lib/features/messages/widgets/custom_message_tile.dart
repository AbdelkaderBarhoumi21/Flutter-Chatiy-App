import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/themes/theme.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';

class CustomMessageTile extends StatelessWidget {
  const CustomMessageTile({required this.messageData, super.key});
  final MessageModel messageData;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Avatar.medium(url: messageData.profilePicture),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                messageData.senderName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  letterSpacing: 0.2,
                  wordSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),

            SizedBox(
              height: 20,
              child: Text(
                messageData.message,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textFaded,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .end,
                children: [
                  SizedBox(height: 4),
                  Text(
                    messageData.dateMessage.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      letterSpacing: -0.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFaded,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textLigth,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
