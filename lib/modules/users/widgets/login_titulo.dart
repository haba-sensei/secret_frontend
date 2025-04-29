import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/core/constant/const_texts.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';

Widget loginTitulo() {
  return Column(
    children: [
      Text(
        MyConst.titulo,
        style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: MyColors.baseTextColorWhite),
      ),
      const SizedBox(height: 10),
      Text(
        MyConst.slogan,
        style: TextStyle(
          fontSize: 18,
          color: MyColors.baseTextColorWhite,
          fontWeight: FontWeight.w400,
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
