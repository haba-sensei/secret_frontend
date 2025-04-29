import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tu_agenda_ya/core/utils/preloaded_assets.dart';

void customSpinner() {
  final composition = PreloadedAssets().loadingSpinner;

  Get.dialog(
    Center(
      child: Container(
        child: composition != null
            ? Lottie(
                composition: composition,
                width: 300,
                height: 300,
              )
            : const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
      ),
    ),
    barrierDismissible: false,
    barrierColor: Colors.black45,
  );
}

void hideCustomLottieLoader() {
  Get.back(); // Use this to dismiss the dialog
}
