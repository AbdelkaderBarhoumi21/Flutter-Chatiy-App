import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/themes/theme.dart';
import 'package:flutter_chatiy_app/features/home/pages/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Chat App',
    theme: AppTheme.lightBase,
    darkTheme: AppTheme.darkBase,
    themeMode: ThemeMode.light,
    home: const HomeScreen(),
  );
}
