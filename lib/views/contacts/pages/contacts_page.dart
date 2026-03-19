import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/controllers/contacts_controller.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/widgets/errors/display_error_message.dart';
import 'package:flutter_chatiy_app/views/contacts/widgets/contacts_tile.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late ContactsController _controller;

  @override
  void initState() {
    super.initState();
    final client = context.client;
    _controller = ContactsController(client: client);
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PagedValueListenableBuilder<int, User>(
    valueListenable: _controller.userListController,
    builder: (context, value, child) => value.when(
      (users, nextPageKey, error) {
        if (users.isEmpty) {
          return const Center(
            child: Text('No users found', style: TextStyle(fontSize: 16)),
          );
        }

        return Scrollbar(
          child: ListView.builder(
            itemCount: users.length + (nextPageKey != null ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == users.length) {
                _controller.loadMore(index);
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final user = users[index];
              return ContactsTile(user: user);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => DisplayErrorMessage(error: error),
    ),
  );
}
