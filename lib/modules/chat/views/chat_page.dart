import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/modules/chat/logic/chat_logic.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: ChatLogic(),
    );
  }
}
