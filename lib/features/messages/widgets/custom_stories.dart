import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/constans/app_colors.dart';
import 'package:flutter_chatiy_app/core/utils/helpers/app_helpers.dart';
import 'package:flutter_chatiy_app/data/models/stories/stories_model.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_stories_card.dart';

class CustomStories extends StatelessWidget {
  const CustomStories({super.key});

  @override
  Widget build(BuildContext context) => Card(
    elevation: 0,
    child: SizedBox(
      height: 134,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 16.0),
            child: Text(
              'Stories',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: AppColors.textFaded,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,

              itemBuilder: (context, index) {
                final fakerData = Faker();

                return SizedBox(
                  width: 60,
                  child: CustomStoriesCard(
                    stories: StoriesModel(
                      name: fakerData.person.name(),
                      url: AppHelpers.randomPictureUrl(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
