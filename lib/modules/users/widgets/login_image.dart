import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tu_agenda_ya/core/utils/preloaded_assets.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    final composition = PreloadedAssets().loginLottie;

    return Center(
      child: composition != null
          ? Lottie(
              composition: composition,
              width: 350,
              height: 350,
            )
          : const CircularProgressIndicator(),
    );
  }
}
