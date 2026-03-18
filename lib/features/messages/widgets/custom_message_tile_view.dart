import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/helpers/app_helpers.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_message_tile.dart';
import 'package:jiffy/jiffy.dart';
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
  Widget build(BuildContext context) {
    final lastMessage = channel.state?.messages.lastOrNull;
    final lastMessageDate = lastMessage?.createdAt ?? DateTime.now();
    final channelName = channel.name ?? channel.id ?? 'Unknown';
    final otherMembers = channel.state?.members
        .where((m) => m.userId != channel.client.state.currentUser?.id)
        .toList();
    final profilePicture = otherMembers?.firstOrNull?.user?.image ??
        AppHelpers.randomPictureUrl();

    return CustomMessageTile(
      messageData: MessageModel(
        senderName: channelName,
        message: lastMessage?.text ?? 'No messages yet',
        messageDate: lastMessageDate,
        dateMessage: Jiffy.parseFromDateTime(lastMessageDate).fromNow(),
        profilePicture: profilePicture,
      ),
    );
  }
}
