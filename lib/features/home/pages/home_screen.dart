import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_user_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/core/widgets/buttons/custom_icon_buttons.dart';
import 'package:flutter_chatiy_app/features/calls/pages/call_page.dart';
import 'package:flutter_chatiy_app/features/contacts/pages/contacts_page.dart';
import 'package:flutter_chatiy_app/features/messages/pages/message_page.dart';
import 'package:flutter_chatiy_app/features/navigation_menu/widgets/custom_navigation_bar_view.dart';
import 'package:flutter_chatiy_app/features/notifications/pages/notifications_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier('Messages');

  final List<Widget> _pages = const [
    MessagePage(),
    NotificationsPage(),
    CallPage(),
    ContactsPage(),
  ];
  final _pageTitles = const ['Messages', 'Notifications', 'Calls', 'Contacts'];

  void _onNavigationItemSelected(int index) {
    title.value = _pageTitles[index];
    pageIndex.value = index;
  }

  @override
  void dispose() {
    pageIndex.dispose();
    title.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      iconTheme: Theme.of(context).iconTheme,
      centerTitle: true,
      title: ValueListenableBuilder(
        valueListenable: title,
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

    body: ValueListenableBuilder(
      valueListenable: pageIndex,
      builder: (context, value, child) => _pages[value],
    ),
    bottomNavigationBar: CustomNavigationBarView(
      onItemSelected: _onNavigationItemSelected,
    ),
  );
}
