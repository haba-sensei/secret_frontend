import 'package:tu_agenda_ya/modules/users/logic/users_logic.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UsersLogic(),
    );
  }
}
