import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:flutter_chatiy_app/core/utils/helpers/app_helpers.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_last_message_date.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_last_message_text.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomMessageTile extends StatelessWidget {
  const CustomMessageTile({required this.channel, super.key});

  final Channel channel;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: () =>
          context.pushNamed(AppRouteNames.chatScreen, arguments: channel),
      child: Row(
        children: [
          Avatar.medium(
            url: AppHelpers.getChannelImage(channel, context.currentUser!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                Text(
                  AppHelpers.getChannelName(channel, context.currentUser!),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    letterSpacing: 0.2,
                    wordSpacing: 1.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                CustomLastMessageText(channel: channel),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomLastMessageDate(channel: channel),
              const SizedBox(height: 8),
              Container(
                width: 18,
                height: 18,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '1',
                  style: TextStyle(fontSize: 10, color: AppColors.textLight),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
