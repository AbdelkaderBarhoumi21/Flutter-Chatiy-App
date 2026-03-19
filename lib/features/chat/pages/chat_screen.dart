import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/custom_icon_buttons.dart';
import 'package:flutter_chatiy_app/core/widgets/errors/display_error_message.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_action_bar.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_chat_screen_app_bar_title.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_message_list.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.channel, super.key});
  final Channel channel;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamSubscription<int> unreadCountSubscription;

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void initState() {
    unreadCountSubscription = StreamChannel.of(
      context,
    ).channel.state!.unreadCountStream.listen(_unreadCountHandler);
    super.initState();
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    super.dispose();
  }

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
      title: CustomChatScreenAppBarTitle(channel: widget.channel),
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
    body: Column(
      children: [
        Expanded(
          child: MessageListCore(
            loadingBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            emptyBuilder: (context) => const SizedBox.shrink(),
            errorBuilder: (context, error) => DisplayErrorMessage(error: error),
            messageListBuilder: (context, messages) =>
                CustomMessageList(messages: messages),
          ),
        ),
        const CustomChatScreenActionBar(),
      ],
    ),
  );
}
