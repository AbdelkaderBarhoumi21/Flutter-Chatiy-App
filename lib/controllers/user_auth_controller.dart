import 'package:flutter_chatiy_app/models/users/demo_users.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Controller for managing user authentication business logic
/// Handles user login and logout operations
class UserAuthController {
  UserAuthController({required this.client});

  final StreamChatClient client;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// Connect a user to Stream Chat
  /// Returns true if successful, false otherwise
  Future<bool> connectUser({
    required DemoUser user,
    required void Function({required bool isLoading}) setLoading,
  }) async {
    setLoading(isLoading: true);
    _isLoading = true;

    try {
      await client.connectUser(
        User(id: user.id, extraData: {'name': user.name, 'image': user.image}),
        client.devToken(user.id).rawValue,
      );
      _isLoading = false;
      return true;
    } on Exception catch (_) {
      _isLoading = false;
      setLoading(isLoading: false);
      return false;
    }
  }

  /// Disconnect the current user from Stream Chat
  /// Returns true if successful, false otherwise
  Future<bool> disconnectUser({
    required void Function({required bool isLoading}) setLoading,
  }) async {
    setLoading(isLoading: true);
    _isLoading = true;

    try {
      await client.disconnectUser();
      _isLoading = false;
      return true;
    } on Exception catch (_) {
      _isLoading = false;
      setLoading(isLoading: false);
      return false;
    }
  }
}
