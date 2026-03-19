import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/utils/helpers/app_helpers.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/core/widgets/connection/connection_status_build.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_connected_title_state.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomChatScreenAppBarTitle extends StatelessWidget {
  const CustomChatScreenAppBarTitle({required this.channel, super.key});
  final Channel channel;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Avatar.small(
        url: AppHelpers.getChannelImage(channel, context.currentUser!),
      ),
      const SizedBox(width: 16),

      Expanded(
        child: Column(
          crossAxisAlignment: .start,
          mainAxisAlignment: .center,
          children: [
            Text(
              AppHelpers.getChannelName(channel, context.currentUser!),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 2),

            BetterStreamBuilder<List<Member>>(
              stream: channel.state!.membersStream,
              initialData: channel.state!.members,
              builder: (context, data) => ConnectionStatusBuilder(
                statusBuilder: (context, status) {
                  switch (status) {
                    case ConnectionStatus.connected:
                      return CustomConnectedTitleState(
                        channel: channel,
                        members: data,
                      );
                    case ConnectionStatus.connecting:
                      return const Text(
                        'Connecting',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      );
                    case ConnectionStatus.disconnected:
                      return const Text(
                        'Offline',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
