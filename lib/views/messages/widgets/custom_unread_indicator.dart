import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomUnreadIndicator extends StatelessWidget {
  const CustomUnreadIndicator({required this.channel, super.key});

  final Channel channel;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: BetterStreamBuilder(
      initialData: channel.state!.unreadCount,
      stream: channel.state!.unreadCountStream,
      builder: (context, data) {
        if (data == 0) {
          return const SizedBox.shrink();
        }
        return Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${data > 99 ? '99+' : data}',
            style: const TextStyle(fontSize: 11, color: AppColors.textLight),
          ),
        );
      },
    ),
  );
}
