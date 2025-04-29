import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/modules/users/controller/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tu_agenda_ya/modules/users/widgets/login_image.dart';
import 'package:tu_agenda_ya/modules/users/widgets/login_social_google_btn.dart';
import 'package:tu_agenda_ya/modules/users/widgets/login_titulo.dart';

class UsersLogic extends StatelessWidget {
  const UsersLogic({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(
      init: UsersController(),
      builder: (UsersController cntrl) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColors.primaryColor, MyColors.secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LoginImage(),
                    loginTitulo(),
                    loginGoogleBtn(cntrl),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
