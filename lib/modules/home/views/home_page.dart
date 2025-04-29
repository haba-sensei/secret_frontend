import 'package:tu_agenda_ya/core/widgets/main_body.dart';
import 'package:tu_agenda_ya/modules/home/logic/home_logic.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainBody(
      body: HomeLogic(),
    );
  }
}
