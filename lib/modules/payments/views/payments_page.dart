import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/modules/payments/logic/payments_logic.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: PaymentsLogic(),
    );
  }
}
