import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Widget that builds itself based on the latest snapshot of interaction with
/// a [Stream] of type [ConnectionStatus].
///
/// The widget will use the closest [StreamChatClient.wsConnectionStatusStream]
/// in case no stream is provided.
class ConnectionStatusBuilder extends StatelessWidget {
  const ConnectionStatusBuilder({
    required this.statusBuilder,
    this.connectionStatusStream,
    this.errorBuilder,
    this.loadingBuilder,
    super.key,
  });

  /// The asynchronous computation to which this builder is currently connected.
  final Stream<ConnectionStatus>? connectionStatusStream;

  /// The builder that will be used in case of error
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  /// The builder that will be used in case of data
  final Widget Function(BuildContext context, ConnectionStatus status)
  statusBuilder;

  /// The builder that will be used in case of loading
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    final stream =
        connectionStatusStream ??
        StreamChatCore.of(context).client.wsConnectionStatusStream;
    final client = context.client;
    return BetterStreamBuilder(
      stream: stream,
      initialData: client.wsConnectionStatus,
      noDataBuilder: loadingBuilder,
      errorBuilder: (context, error) {
        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }
        return const Offstage(); // hide or show widget
      },
      builder: statusBuilder,
    );
  }
}
