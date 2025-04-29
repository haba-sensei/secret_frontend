import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/modules/users/controller/users_controller.dart';
import 'package:tu_agenda_ya/modules/users/widgets/login_butons.dart';

Widget loginGoogleBtn(UsersController cntrl) {
  return buildLoginButton(
    'assets/google.svg',
    'Ingresa con google',
    () async => await cntrl.loginGoogle(),
    const Color(0xFFFFFEFE),
  );
}
