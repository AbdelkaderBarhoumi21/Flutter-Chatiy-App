import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/glowing_actions_buttons.dart';

class CustomChatScreenActionBar extends StatelessWidget {
  const CustomChatScreenActionBar({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(CupertinoIcons.camera_fill),
          ),
        ),

        const Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: TextField(
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Type a message.....',
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 24.0),
          child: GlowingActionButton(
            color: AppColors.accent,
            icon: Icons.send,
            onPressed: () {
              //Todo send message
            },
          ),
        ),
      ],
    ),
  );
}
