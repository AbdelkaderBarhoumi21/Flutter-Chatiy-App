import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/controllers/user_auth_controller.dart';
import 'package:flutter_chatiy_app/core/app/app.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';

class SignoutButton extends StatefulWidget {
  const SignoutButton({super.key});

  @override
  State<SignoutButton> createState() => _SignoutButtonState();
}

class _SignoutButtonState extends State<SignoutButton> {
  late UserAuthController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final client = context.client;
    _controller = UserAuthController(client: client);
  }

  Future<void> _signout() async {
    final success = await _controller.disconnectUser(
      setLoading: ({required bool isLoading}) {
        if (mounted) {
          setState(() {
            _isLoading = isLoading;
          });
        }
      },
    );

    if (success && mounted) {
      context.pushNamed(AppRouteNames.selectUserScreen);
    } else if (!success) {
      logger.e('Could not sign out');
    }
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const CircularProgressIndicator()
      : TextButton(onPressed: _signout, child: const Text('Signout'));
}
