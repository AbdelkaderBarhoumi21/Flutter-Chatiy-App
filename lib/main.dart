import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/app/app.dart';
import 'package:flutter_chatiy_app/app/my_app.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

void main() {
  final client = StreamChatClient(streamKey);
  runApp(MyApp(client: client));
}
