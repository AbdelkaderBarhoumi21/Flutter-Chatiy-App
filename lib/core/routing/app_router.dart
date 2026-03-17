import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/features/chat/pages/chat_screen.dart';
import 'package:flutter_chatiy_app/features/home/pages/home_screen.dart';
import 'package:flutter_chatiy_app/features/users/pages/select_user_screen.dart';

class AppRouter {
  /// Generates routes based on [RouteSettings] provided by the navigator.
  ///
  /// This method is called by MaterialApp's `onGenerateRoute` callback
  /// whenever navigation occurs. It matches the route name, validates
  /// arguments, and returns a [MaterialPageRoute] with the appropriate screen.
  ///
  /// Returns an error route if the route name is unknown or arguments are invalid.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.chatScreen:
        final messageModel = settings.arguments;
        if (messageModel is MessageModel) {
          return MaterialPageRoute(
            builder: (_) => ChatScreen(messageModel: messageModel),
          );
        }
        return _errorRoute('Invalid arguments for ChatScreen');
      case AppRouteNames.selectUserScreen:
        return MaterialPageRoute(builder: (_) => const SelectUserScreen());
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return _errorRoute('Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) => MaterialPageRoute(
    builder: (_) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(child: Text(message)),
    ),
  );
}
