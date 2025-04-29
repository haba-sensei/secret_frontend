import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/modules/favoritos/controller/favoritos_controller.dart';

class FavoritosLogic extends StatelessWidget {
  const FavoritosLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GetX<FavoritosController>(
      init: FavoritosController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return SafeArea(
            child: Center(
              child: Text('llege Favoritos'),
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
            child: Text('llege Favoritos'),
          ),
        );
      },
    );
  }
}
