import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_date_label.dart';

class CustomMessageList extends StatelessWidget {
  const CustomMessageList({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: ListView(children: const [CustomDateLabel(label: 'Yesterday')]),
  );
}
