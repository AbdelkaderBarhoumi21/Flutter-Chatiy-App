import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/pages/call_page.dart';
import 'package:flutter_chatiy_app/pages/contacts_page.dart';
import 'package:flutter_chatiy_app/pages/message_page.dart';
import 'package:flutter_chatiy_app/pages/notifications_page.dart';
import 'package:flutter_chatiy_app/widgets/custom_icon_buttons.dart';

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
        Padding(padding: const EdgeInsets.only(
          right: 24.0
        ))
      ],
    ),
  );
}
