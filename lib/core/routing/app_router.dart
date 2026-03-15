import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/features/messages/pages/message_page.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case AppRouteNames.chatScreen:
        return MaterialPageRoute(builder: (_) => const MessagePage());
    }
    return null;
  }
}
