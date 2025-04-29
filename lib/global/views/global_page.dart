import 'package:tu_agenda_ya/global/logic/global_logic.dart';
import 'package:flutter/material.dart';

class GlobalPage extends StatelessWidget {
  const GlobalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: GlobalLogic(),
      ),
    );
  }
}
