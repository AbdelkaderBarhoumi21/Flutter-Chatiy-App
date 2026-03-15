import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/widgets/avatar/avatar.dart';
import 'package:flutter_chatiy_app/data/models/stories/stories_model.dart';

class CustomStoriesCard extends StatelessWidget {
  const CustomStoriesCard({required this.stories, super.key});
  final StoriesModel stories;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: .min,
    mainAxisAlignment: .center,

    children: [
      Avatar.medium(url: stories.url),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            stories.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              letterSpacing: 0.3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
