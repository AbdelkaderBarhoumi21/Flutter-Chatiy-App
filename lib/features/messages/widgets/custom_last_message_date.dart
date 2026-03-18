import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomLastMessageDate extends StatelessWidget {
  const CustomLastMessageDate({required this.channel, super.key});
  final Channel channel;

  @override
  Widget build(BuildContext context) => BetterStreamBuilder<DateTime>(
    stream: channel.lastMessageAtStream,
    initialData: channel.lastMessageAt,
    builder: (context, data) {
      final lastMessageAt = data.toLocal();
      String stringDate;
      final now = DateTime.now();

      final startOfDay = DateTime(now.year, now.month, now.day);

      if (lastMessageAt.millisecondsSinceEpoch >=
          startOfDay.millisecondsSinceEpoch) {
        //.jm Returns 12 hour and minute. Example: 12:11 PM
        stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).jm;
      } else if (lastMessageAt.millisecondsSinceEpoch >=
          startOfDay.subtract(const Duration(days: 1)).millisecondsSinceEpoch) {
        stringDate = 'YESTERDAY';
      } else if (startOfDay.difference(lastMessageAt).inDays < 7) {
        //return the day for example tuesday
        stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).EEEE;
      } else {
        //Returns the year, of month and date. Example: 9/23/1997
        stringDate = Jiffy.parseFromDateTime(lastMessageAt.toLocal()).yMd;
      }
      return Text(
        stringDate,
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: -0.2,
          fontWeight: FontWeight.w600,
          color: AppColors.textFaded,
        ),
      );
    },
  );
}
