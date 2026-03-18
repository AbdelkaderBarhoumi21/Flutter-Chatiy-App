import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/widgets/errors/display_error_message.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_message_tile_view.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_stories.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late final StreamChannelListController _channelListController;

  @override
  void initState() {
    super.initState();
    final client = StreamChatCore.of(context).client;
    _channelListController = StreamChannelListController(
      client: client,
      filter: Filter.in_('members', [client.state.currentUser!.id]),
      channelStateSort: [const SortOption.desc(ChannelSortKey.lastMessageAt)],
      limit: 20,
    );

    // Create demo channels if none exist
    unawaited(_createDemoChannelsIfNeeded());
  }

  Future<void> _createDemoChannelsIfNeeded() async {
    try {
      final client = StreamChatCore.of(context).client;
      final currentUserId = client.state.currentUser?.id;

      if (currentUserId == null) return;

      // Create a test channel with another demo user
      final channel = client.channel(
        'messaging',
        id: 'demo-channel-$currentUserId',
        extraData: {
          'name': 'Test Chat',
          'members': [currentUserId],
        },
      );

      await channel.watch();

      // Send a welcome message
      await channel.sendMessage(
        Message(text: 'Welcome to your first chat! 👋'),
      );

      // Refresh the list
      _channelListController.doInitialLoad();
    } catch (e) {
      debugPrint('Error creating demo channel: $e');
    }
  }

  @override
  void dispose() {
    _channelListController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => PagedValueListenableBuilder<int, Channel>(
    // value = PagedValue<int, Channel> : state
    valueListenable: _channelListController,
    builder: (context, value, child) => value.when(
      (channels, nextPageKey, error) {
        if (channels.isEmpty) {
          return const Center(
            child: Text(
              'So empty\nGo and message someone!',
              textAlign: TextAlign.center,
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: CustomStories()),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index == channels.length) {
                  _channelListController.loadMore(index);
                  return const Center(child: CircularProgressIndicator());
                }
                final channel = channels[index];
                return CustomMessageTileView(index: index, channel: channel);
              }, childCount: channels.length + (nextPageKey != null ? 1 : 0)),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error) => DisplayErrorMessage(error: error),
    ),
  );
}
