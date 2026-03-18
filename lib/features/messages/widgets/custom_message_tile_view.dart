import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_message_tile.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomMessageTileView extends StatelessWidget {
  const CustomMessageTileView({
    required this.index,
    required this.channel,
    super.key,
  });
  final int index;
  final Channel channel;

  @override
  Widget build(BuildContext context) => CustomMessageTile(channel: channel);
}
