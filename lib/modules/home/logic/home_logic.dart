import 'package:tu_agenda_ya/modules/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeLogic extends StatelessWidget {
  const HomeLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GetX<HomeController>(
      init: HomeController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return SafeArea(
            child: Center(
              child: Text('llege HOME'),
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
            child: Text('llege HOME'),
          ),
        );
      },
    );
  }
}
