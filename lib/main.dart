import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/screens/screens.dart';
import 'package:flutter_chatiy_app/theme.dart';

void main() {
  runApp(const MyApp());
}

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
