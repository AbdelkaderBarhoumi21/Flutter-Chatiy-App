import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/app/app.dart';
import 'package:flutter_chatiy_app/core/extension/app_route_extension.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:flutter_chatiy_app/core/routing/app_route_names.dart';
import 'package:flutter_chatiy_app/data/models/users/demo_users.dart';
import 'package:flutter_chatiy_app/features/users/widgets/select_user_button.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  bool _isLoading = false;

  /// Called when a user is selected from the list.
  /// Connects the selected user to Stream Chat and navigates to the chat screen.
  ///
  /// Steps:
  /// 1. Shows loading indicator
  /// 2. Gets the StreamChatClient instance
  /// 3. Connects the user with their profile data (id, name, image)
  /// 4. Generates a dev token for authentication (dev mode only)
  /// 5. Navigates to chat screen on success
  /// 6. Handles errors and stops loading on failure
  Future<void> onUserSelected(DemoUser user) async {
    // Show loading indicator while connecting
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the Stream Chat client from context
      final client = context.client;

      // Connect the user to Stream Chat with their profile data
      await client.connectUser(
        User(id: user.id, extraData: {'name': user.name, 'image': user.image}),
        // Generate dev token (WARNING: only for development, not production!)
        client.devToken(user.id).rawValue,
      );

      // Navigate to chat screen after successful connection
      context.pushReplacementNamed(AppRouteNames.home);
    } on Exception catch (e, stackTrace) {
      // Log error if connection fails
      logger.e('Could not connect user', error: e, stackTrace: stackTrace);

      // Stop loading indicator to allow user to retry
      setState(() {
        _isLoading = false;
      });
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
