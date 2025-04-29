import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tu_agenda_ya/core/utils/text_style.dart';

Widget buildLoginButton(
  String assetPath,
  String label,
  Future<void> Function() onTap,
  Color backgroundColor,
) {
  return SizedBox(
    height: 50,
    width: 250,
    child: ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            assetPath,
            height: 22,
            width: 22,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: MyTxtStyle.mainSubTitle,
          ),
        ],
      ),
    ),
  );
}
