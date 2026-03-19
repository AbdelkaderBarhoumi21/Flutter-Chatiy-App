import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/features/chat/widgets/custom_typing_indicator.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class CustomConnectedTitleState extends StatelessWidget {
  const CustomConnectedTitleState({this.members, super.key});
  final List<Member>? members;

  @override
  Widget build(BuildContext context) {
    return CustomTypingIndicator();
  }
}
