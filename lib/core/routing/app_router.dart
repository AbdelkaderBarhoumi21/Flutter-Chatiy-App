import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/features/chat/pages/chat_screen.dart';
import 'package:flutter_chatiy_app/features/users/pages/select_user_screen.dart';

/// Centralized routing configuration for the application.
///
/// This class handles all route generation and navigation logic. When you
/// navigate using `context.pushNamed()`, Flutter calls [generateRoute] with
/// a [RouteSettings] object containing:
/// - `name`: The route identifier (e.g., '/chat')
/// - `arguments`: Optional data passed to the destination screen
///
/// Example:
/// ```dart
/// // Navigate to chat screen with message data
/// context.pushNamed(
///   AppRouteNames.chatScreen,
///   arguments: messageModel,
/// );
/// ```
///
/// The router validates arguments and returns appropriate routes, or an error
/// screen if the route is invalid or arguments don't match expected types.
///
/// **What is MaterialPageRoute?**
///
/// [MaterialPageRoute] is a Flutter class that creates a route with Material
/// Design page transitions:
/// - On Android: Slides up from bottom with fade-in
/// - On iOS: Slides in from right (following platform conventions)
/// - Provides back button/gesture support automatically
/// - Handles the route's lifecycle (build, animation, disposal)
///
/// It wraps your screen widget and manages how it appears/disappears during
/// navigation. The `builder` function creates the actual screen widget when
/// the route is pushed.
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
