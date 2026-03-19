import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/controllers/message_controller.dart';
import 'package:flutter_chatiy_app/core/widgets/errors/display_error_message.dart';
import 'package:flutter_chatiy_app/views/messages/widgets/custom_message_tile_view.dart';
import 'package:flutter_chatiy_app/views/messages/widgets/custom_stories.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late MessageController _controller;

  @override
  void initState() {
    super.initState();
    final client = StreamChatCore.of(context).client;
    _controller = MessageController(client: client);
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => PagedValueListenableBuilder<int, Channel>(
    // value = PagedValue<int, Channel> : state
    valueListenable: _controller.channelListController,
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
                  _controller.loadMore(index);
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
