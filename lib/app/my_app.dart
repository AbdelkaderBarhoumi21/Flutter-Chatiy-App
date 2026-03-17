import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/routing/app_router.dart';
import 'package:flutter_chatiy_app/core/themes/theme.dart';
import 'package:flutter_chatiy_app/features/users/pages/select_user_screen.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MyApp extends StatelessWidget {
  const MyApp({required this.client, super.key});
  final StreamChatClient client;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Chat App',
    theme: AppTheme.instance.light,
    darkTheme: AppTheme.instance.dark,
    themeMode: ThemeMode.light,
    onGenerateRoute: AppRouter.generateRoute,
    builder: (context, child) => StreamChatCore(client: client, child: child!),
    home: const SelectUserScreen(),
  );
}
