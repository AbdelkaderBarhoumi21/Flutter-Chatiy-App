import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/controllers/home_navigation_controller.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/custom_icon_buttons.dart';
import 'package:flutter_chatiy_app/views/calls/pages/call_page.dart';
import 'package:flutter_chatiy_app/views/contacts/pages/contacts_page.dart';
import 'package:flutter_chatiy_app/views/messages/pages/message_page.dart';
import 'package:flutter_chatiy_app/views/navigation_menu/widgets/custom_navigation_bar_view.dart';
import 'package:flutter_chatiy_app/views/notifications/pages/notifications_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeNavigationController _controller;

  final List<Widget> _pages = const [
    MessagePage(),
    NotificationsPage(),
    CallPage(),
    ContactsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = HomeNavigationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: true,
      title: ValueListenableBuilder<String>(
        valueListenable: _controller.title,
        builder: (context, value, child) => Text(value),
      ),
      leadingWidth: 54,
      leading: Align(
        alignment: Alignment.centerRight,
        child: IconBackgroundButtons(
          icon: Icons.search,
          onTap: () {
            // Todo Search
          },
        ),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Hero(
            tag: 'hero-profile-picture',
            child: Avatar.small(
              url: context.currentUserImage,
              onTap: () {
                context.pushNamed(AppRouteNames.profileScreen);
              },
            ),
          ),
        ),
      ],
    ),

    body: ValueListenableBuilder<int>(
      valueListenable: _controller.pageIndex,
      builder: (context, value, child) => _pages[value],
    ),
    bottomNavigationBar: CustomNavigationBarView(
      onItemSelected: _controller.onNavigationItemSelected,
    ),
  );
}
