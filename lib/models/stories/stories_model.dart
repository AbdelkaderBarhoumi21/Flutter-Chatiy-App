import 'package:flutter/foundation.dart' show immutable;

@immutable
class StoriesModel {
  const StoriesModel({required this.name, required this.url});
  final String name;
  final String url;
}
