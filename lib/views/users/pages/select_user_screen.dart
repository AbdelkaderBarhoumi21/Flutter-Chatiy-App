import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/controllers/user_auth_controller.dart';
import 'package:flutter_chatiy_app/core/app/app.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/models/users/demo_users.dart';
import 'package:flutter_chatiy_app/views/users/widgets/select_user_button.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  late UserAuthController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final client = context.client;
    _controller = UserAuthController(client: client);
  }

  /// Called when a user is selected from the list
  Future<void> onUserSelected(DemoUser user) async {
    final success = await _controller.connectUser(
      user: user,
      setLoading: ({required bool isLoading}) {
        if (mounted) {
          setState(() {
            _isLoading = isLoading;
          });
        }
      },
    );

    if (success && mounted) {
      context.pushReplacementNamed(AppRouteNames.home);
    } else if (!success) {
      logger.e('Could not connect user');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      'Select a user',
                      style: TextStyle(fontSize: 14, letterSpacing: 0.4),
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) => SelectUserButton(
                        user: users[index],
                        onPressed: onUserSelected,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ),
  );
}
