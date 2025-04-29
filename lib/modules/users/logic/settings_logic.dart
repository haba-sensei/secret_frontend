import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/modules/users/controller/settings_controller.dart';

class SettingsLogic extends StatelessWidget {
  const SettingsLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return SafeArea(
            child: Center(
              child: Text('llege Settings'),
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
            child: Text('llege Settings'),
          ),
        );
      },
    );
  }
}
