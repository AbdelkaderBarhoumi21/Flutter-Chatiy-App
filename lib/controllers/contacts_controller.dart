import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Controller for managing contacts list business logic
/// Handles fetching and managing user list
class ContactsController {
  ContactsController({required this.client});

  final StreamChatClient client;
  late StreamUserListController userListController;

  /// Initialize the controller and load initial data
  void init() {
    userListController = StreamUserListController(
      client: client,
      filter: Filter.and([Filter.notEqual('id', client.state.currentUser!.id)]),
      sort: const [SortOption.asc('name')],
      limit: 20,
    );
    userListController.doInitialLoad();
  }

  /// Load more users for pagination
  void loadMore(int index) {
    userListController.loadMore(index);
  }

  /// Clean up resources
  void dispose() {
    userListController.dispose();
  }
}
