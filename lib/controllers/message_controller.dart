import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Controller for managing message list business logic
/// Handles fetching and managing channel list
class MessageController {
  MessageController({required this.client});

  final StreamChatClient client;
  late StreamChannelListController channelListController;

  /// Initialize the controller and load initial data
  void init() {
    channelListController = StreamChannelListController(
      client: client,
      filter: Filter.in_('members', [client.state.currentUser!.id]),
      channelStateSort: const [SortOption.desc(ChannelSortKey.lastMessageAt)],
      limit: 20,
    );
    channelListController.doInitialLoad();
  }

  /// Load more channels for pagination
  void loadMore(int index) {
    channelListController.loadMore(index);
  }

  /// Clean up resources
  void dispose() {
    channelListController.dispose();
  }
}
