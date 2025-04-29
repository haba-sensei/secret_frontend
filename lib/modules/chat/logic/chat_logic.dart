import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/modules/chat/controller/chat_controller.dart';

class ChatLogic extends StatelessWidget {
  const ChatLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GetX<ChatController>(
      init: ChatController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return SafeArea(
            child: Center(
              child: Text('llege Chat'),
            ),
          );
          // return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          logger.e("Error: ${controller.errorMessage.value}");
          return Center(child: Text(controller.errorMessage.value));
        }

        return SafeArea(
          child: Center(
            child: Text('llege Chat'),
          ),
        );
      },
    );
  }
}
