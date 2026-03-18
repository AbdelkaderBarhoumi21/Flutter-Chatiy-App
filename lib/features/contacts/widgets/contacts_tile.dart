import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_user_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ContactsTile extends StatelessWidget {
  const ContactsTile({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    Future<void> createChannel() async {
      try {
        final client = StreamChatCore.of(context).client;
        final currentUserId = client.state.currentUser?.id;
        if (currentUserId == null) return;

        // Create a test channel with another demo user
        final channel = client.channel(
          'messaging',
          extraData: {
            'members': [context.currentUser?.id, user.id],
          },
        );
        await channel.watch();
        context.pushNamed(AppRouteNames.chatScreen, arguments: channel);
      } catch (e) {
        debugPrint('Error creating demo channel: $e');
      }
    }

    return InkWell(
      onTap: createChannel,
      child: ListTile(
        leading: Avatar.small(url: user.image),
        title: Text(user.name),
      ),
    );
  }
}
