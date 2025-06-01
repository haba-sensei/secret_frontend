import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/modules/stores/controller/stores_controller.dart';

class StoresListLogic extends StatelessWidget {
  const StoresListLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GetX<StoresController>(
      init: StoresController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return SafeArea(
            child: Center(
              child: Text('llege Stores list'),
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
            child: Text('llege Stores list'),
          ),
        );
      },
    );
  }
}
