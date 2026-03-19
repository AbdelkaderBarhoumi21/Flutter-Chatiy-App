import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:jiffy/jiffy.dart';

class CustomDateLabel extends StatefulWidget {
  const CustomDateLabel({required this.dateTime, super.key});
  final DateTime dateTime;

  @override
  State<CustomDateLabel> createState() => _CustomDateLabelState();
}

class _CustomDateLabelState extends State<CustomDateLabel> {
  late String dayInfo;

  @override
  void initState() {
    final createdAt = Jiffy.parseFromDateTime(widget.dateTime);
    final now = DateTime.now();

    if (Jiffy.parseFromJiffy(
      createdAt,
    ).isSame(Jiffy.parseFromDateTime(now), unit: Unit.day)) {
      dayInfo = 'Today';
    } else if (Jiffy.parseFromJiffy(createdAt).isSame(
      Jiffy.parseFromDateTime(now.subtract(const Duration(days: 1))),
      unit: Unit.day,
    )) {
      dayInfo = 'Yesterday';
    } else if (Jiffy.parseFromJiffy(createdAt).isAfter(
      Jiffy.parseFromDateTime(now.subtract(const Duration(days: 7))),
      unit: Unit.day,
    )) {
      dayInfo = createdAt.EEEE; // Returns the weekday. Example: `Tuesday`
    } else if (Jiffy.parseFromJiffy(createdAt).isAfter(
      Jiffy.parseFromDateTime(now.subtract(const Duration(days: 365))),
      unit: Unit.day,
    )) {
      dayInfo = createdAt.MMMd;
    } else {
      dayInfo = createdAt.MMMd;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).cardColor;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              dayInfo,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
