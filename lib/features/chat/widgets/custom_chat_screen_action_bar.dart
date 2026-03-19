import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/glowing_actions_buttons.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomChatScreenActionBar extends StatefulWidget {
  const CustomChatScreenActionBar({super.key});

  @override
  State<CustomChatScreenActionBar> createState() =>
      _CustomChatScreenActionBarState();
}

class _CustomChatScreenActionBarState extends State<CustomChatScreenActionBar> {
  final TextEditingController controller = TextEditingController();
  Future<void> _sendMessage() async {
    if (controller.text.isNotEmpty) {
      await StreamChannel.of(
        context,
      ).channel.sendMessage(Message(text: controller.text));
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
              onChanged: (val) {
                // Sends the [Event.typingStart]
                StreamChannel.of(context).channel.keyStroke();
              },
              onSubmitted: (_) => _sendMessage(),
              decoration: const InputDecoration(
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
            onPressed: _sendMessage,
          ),
        ),
      ],
    ),
  );
}
