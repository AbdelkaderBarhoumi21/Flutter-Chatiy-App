import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_stories.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) => const CustomScrollView(
    slivers: [SliverToBoxAdapter(child: CustomStories())],
  );
}
