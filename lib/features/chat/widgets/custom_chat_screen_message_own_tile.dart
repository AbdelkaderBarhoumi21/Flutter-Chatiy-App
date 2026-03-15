import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/themes/theme.dart';

class CustomChatScreenMessageOwnTile extends StatelessWidget {
  const CustomChatScreenMessageOwnTile({
    required this.message,
    required this.messageDate,
    super.key,
  });
  final String message;
  final String messageDate;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 26.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .end,
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 20,
                ),
                child: Text(
                  message,
                  style: const TextStyle(color: AppColors.textLigth),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
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
