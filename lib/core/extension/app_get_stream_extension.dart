import 'package:flutter/cupertino.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Extensions can be used to add functionality to the SDK.
extension StreamChatContext on BuildContext {
  /// Fetches the current client.
  Channel get channel => StreamChannel.of(this).channel;

  /// Fetches the current client.
  StreamChatClient get client => StreamChatCore.of(this).client;

  /// Fetches the current user.
  User? get currentUser => StreamChatCore.of(this).currentUser;

  /// Fetches the current user image.
  String? get currentUserImage => currentUser?.image;
}
