import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:tu_agenda_ya/modules/booking/logic/booking_logic.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: BookingLogic(),
    );
  }
}
