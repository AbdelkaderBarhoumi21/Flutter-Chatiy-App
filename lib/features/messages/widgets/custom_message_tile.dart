import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';

import 'package:flutter_chatiy_app/core/themes/theme.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';

class CustomMessageTile extends StatelessWidget {
  const CustomMessageTile({required this.messageData, super.key});

  final MessageModel messageData;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: () =>
          context.pushNamed(AppRouteNames.chatScreen, arguments: messageData),
      child: Row(
        children: [
          Avatar.medium(url: messageData.profilePicture),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                Text(
                  messageData.senderName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    letterSpacing: 0.2,
                    wordSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  messageData.message,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textFaded,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageData.dateMessage.toUpperCase(),
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
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(fontSize: 10, color: AppColors.textLigth),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
