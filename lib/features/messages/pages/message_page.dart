import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChannelListView(
      onChannelTap: (channel) {
        // TODO: Navigate to channel/chat screen
      },
    );
    // return CustomScrollView(
    //   slivers: [
    //     const SliverToBoxAdapter(child: CustomStories()),
    //     SliverList(
    //       delegate: SliverChildBuilderDelegate(
    //         (context, index) => CustomMessageTileView(index: index),
    //         childCount: 20,
    //       ),
    //     ),
    //   ],
    // );
  }
}
