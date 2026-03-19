import 'package:flutter/material.dart';
import 'package:flutter_chatiy_app/core/extension/app_get_stream_extension.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

/// Widget to show the current list of typing users
class CustomTypingIndicator extends StatelessWidget {
  const CustomTypingIndicator({this.alternativeWidget, super.key});

  /// Widget built when no typings is happening
  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    final channelState = context.channel.state!;
    final altWidget = alternativeWidget ?? const SizedBox.shrink();
    return BetterStreamBuilder(
      initialData: channelState.typingEvents.keys, // Iterable<User>  [Alice]
      stream: channelState.typingEventsStream.map(
        (typings) => typings.entries.map((e) => e.key),
      ),
      builder: (context, data) => Align(
        alignment: Alignment.centerLeft,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: data.isNotEmpty == true
              ? const Align(
                  alignment: Alignment.centerLeft,
                  key: ValueKey('typing-text'),
                  child: Text(
                    'Typing message',
                    maxLines: 1,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  key: const ValueKey('altWidget'),
                  child: altWidget,
                ),
        ),
      ),
    );
  }
}
