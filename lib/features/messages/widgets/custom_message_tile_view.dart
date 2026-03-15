import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/utils/helpers/app_helpers.dart';
import 'package:flutter_chatiy_app/data/models/messages/message_model.dart';
import 'package:flutter_chatiy_app/features/messages/widgets/custom_message_tile.dart';
import 'package:jiffy/jiffy.dart';

class CustomMessageTileView extends StatelessWidget {
  const CustomMessageTileView({required this.index, super.key});
  final int index;

  static final _faker = Faker();

  @override
  Widget build(BuildContext context) {
    final date = AppHelpers.randomDate();
    final profilePicture = AppHelpers.randomPictureUrl();
    return CustomMessageTile(
      messageData: MessageModel(
        senderName: _faker.person.name(),
        message: _faker.lorem.sentence(),
        messageDate: date,
        dateMessage: Jiffy.parseFromDateTime(date).fromNow(),
        profilePicture: profilePicture,
      ),
    );
  }
}
