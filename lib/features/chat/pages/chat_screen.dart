import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/custom_icon_buttons.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_action_bar.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_app_bar_title.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_message_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({required this.messageModel, super.key});
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 54,
      leading: Align(
        alignment: Alignment.centerRight,
        child: IconBackgroundButtons(
          icon: CupertinoIcons.back,
          onTap: () => context.pop(),
        ),
      ),
      title: CustomChatScreenAppBarTitle(messageModel: messageModel),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: IconBorderButtons(
              icon: CupertinoIcons.video_camera_solid,
              onTap: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Center(
            child: IconBorderButtons(
              icon: CupertinoIcons.phone_solid,
              onTap: () {},
            ),
          ),
        ),
      ],
    ),
    body: const Column(
      children: [
        Expanded(child: CustomMessageList()),
        CustomChatScreenActionBar(),
      ],
    ),
  );
}
