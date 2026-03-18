import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_user_extension.dart';
import 'package:flutter_chatiy_app/core/utils/helpers/app_helpers.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
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
            const Text(
              'Online now',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
