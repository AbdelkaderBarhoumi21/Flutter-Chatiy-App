import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/features/chat/pages/chat_screen.dart';
import 'package:flutter_chatiy_app/features/home/pages/home_screen.dart';
import 'package:flutter_chatiy_app/features/users/pages/profile_screen.dart';
import 'package:flutter_chatiy_app/features/users/pages/select_user_screen.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

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
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.chatScreen:
        final channel = settings.arguments;
        if (channel is Channel) {
          return MaterialPageRoute(
            builder: (_) => ChatScreen(channel: channel),
          );
        }
        return _errorRoute('Invalid arguments for ChatScreen');
      case AppRouteNames.selectUserScreen:
        return MaterialPageRoute(builder: (_) => const SelectUserScreen());
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRouteNames.profileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

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
