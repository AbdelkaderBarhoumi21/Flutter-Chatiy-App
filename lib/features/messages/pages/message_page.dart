import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_message_tile_view.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_stories.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const SliverToBoxAdapter(child: CustomStories()),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => CustomMessageTileView(index: index),
          childCount: 20,
        ),
      ),
    ],
  );
}
