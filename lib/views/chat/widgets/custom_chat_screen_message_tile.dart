import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomChatScreenMessageTile extends StatelessWidget {
  const CustomChatScreenMessageTile({required this.message, super.key});
  final Message message;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 26.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 20,
                ),
                child: Text(message.text ?? ''),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy.parseFromDateTime(message.createdAt.toLocal()).jm,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
