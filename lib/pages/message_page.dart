import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/widgets/custom_stories.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [const SliverToBoxAdapter(child: CustomStories())],
    );
  }
}
