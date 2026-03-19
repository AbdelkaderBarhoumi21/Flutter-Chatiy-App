import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/views/chat/widgets/custom_typing_indicator.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomConnectedTitleState extends StatelessWidget {
  const CustomConnectedTitleState({
    required this.channel,
    this.members,
    super.key,
  });

  final Channel channel;
  final List<Member>? members;

  @override
  Widget build(BuildContext context) {
    Widget? alternativeWidget;
    final memberCount = channel.memberCount;
    if (memberCount != null && memberCount > 2) {
      var text = 'Members: $memberCount';
      final watcherCount = channel.state?.watcherCount ?? 0;
      if (watcherCount > 0) {
        text = 'watchers $watcherCount';
      }
      alternativeWidget = Text(text);
    } else {
      final userId = context.currentUser?.id;
      final otherMember = members?.firstWhereOrNull((e) => e.userId != userId);
      if (otherMember != null) {
        if (otherMember.user?.online == true) {
          alternativeWidget = const Text(
            'Online',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          );
        } else {
          alternativeWidget = Text(
            'Last online: '
            '${Jiffy.parseFromDateTime(otherMember.user?.lastActive ?? DateTime.now()).fromNow()}',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          );
        }
      }
    }

    return CustomTypingIndicator(
      channel: channel,
      alternativeWidget: alternativeWidget,
    );
  }
}
