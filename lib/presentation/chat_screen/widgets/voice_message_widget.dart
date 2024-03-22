import 'package:flutter/material.dart';
import 'package:mifever/core/app_export.dart';
import 'package:mifever/presentation/chat_screen/models/chat_model.dart';
import 'package:voice_message_package/voice_message_package.dart';

class VoiceMessageWidget extends StatelessWidget {
  const VoiceMessageWidget({Key? key, required this.chat}) : super(key: key);
  final ChatModel chat;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chat.senderId == PrefUtils.getId()
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: VoiceMessageView(
        backgroundColor:
            chat.senderId == PrefUtils.getId() ? Colors.white : appTheme.red50,
        controller: VoiceController(
          audioSrc: chat.url!,
          maxDuration: const Duration(seconds: 60),
          isFile: false,
          onComplete: () {},
          onPause: () {},
          onPlaying: () {},
          onError: (err) {},
        ),
      ),
    );
  }
}
