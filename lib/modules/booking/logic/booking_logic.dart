import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/modules/booking/controller/booking_controller.dart';

class BookingLogic extends StatelessWidget {
  const BookingLogic({super.key});

  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    return GetX<BookingController>(
      init: BookingController(),
      builder: (controller) {
        if (controller.isLoading.value) {
          return SafeArea(
            child: Center(
              child: Text('llege Booking'),
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
            child: Text('llege Booking'),
          ),
        );
      },
    );
  }
}
