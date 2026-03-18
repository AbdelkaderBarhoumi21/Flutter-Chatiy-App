import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_user_extension.dart';
import 'package:flutter_chatiy_app/core/widgets/errors/display_error_message.dart';
import 'package:flutter_chatiy_app/features/contacts/widgets/contacts_tile.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late final StreamUserListController _userListController;

  @override
  void initState() {
    final client = context.client;
    _userListController = StreamUserListController(
      client: client,
      filter: Filter.and([Filter.notEqual('id', client.state.currentUser!.id)]),
      sort: [const SortOption.asc('name')],
      limit: 20,
    );
    _userListController.doInitialLoad();
    super.initState();
  }

  @override
  void dispose() {
    _userListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PagedValueListenableBuilder<int, User>(
    valueListenable: _userListController,
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
                _userListController.loadMore(index);
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
