import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/app/app.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_user_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';

class SignoutButton extends StatefulWidget {
  const SignoutButton({super.key});

  @override
  State<SignoutButton> createState() => _SignoutButtonState();
}

class _SignoutButtonState extends State<SignoutButton> {
  bool _isLoading = false;
  Future<void> _signout() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await context.client.disconnectUser();
      context.pushNamed(AppRouteNames.selectUserScreen);
    } on Exception catch (e, stackTrace) {
      logger.e('Could not sign out', error: e, stackTrace: stackTrace);
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const CircularProgressIndicator()
      : TextButton(onPressed: _signout, child: const Text('Signout'));
}
