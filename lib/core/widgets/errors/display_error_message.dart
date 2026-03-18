import 'package:flutter/material.dart';

class DisplayErrorMessage extends StatelessWidget {
  const DisplayErrorMessage({this.error, super.key});
  final Object? error;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      'Oh no, something went wrong. '
      'Please check your config. $error',
    ),
  );
}
