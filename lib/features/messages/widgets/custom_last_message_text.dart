import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomLastMessageText extends StatelessWidget {
  const CustomLastMessageText({required this.channel, super.key});
  final Channel channel;

  @override
  Widget build(BuildContext context) => BetterStreamBuilder<Message>(
    stream: channel.state!.lastMessageStream,
    initialData: channel.state!.lastMessage,
    builder: (context, lastMessage) => Text(
      lastMessage.text ?? '',
      style: const TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 12,
        color: AppColors.textFaded,
      ),
    ),
  );
}
