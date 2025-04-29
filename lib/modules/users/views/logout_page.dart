import 'package:tu_agenda_ya/modules/users/logic/users_logic.dart';
import 'package:flutter/material.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: UsersLogic(),
      ),
    );
  }
}
