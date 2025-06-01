import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tu_agenda_ya/core/utils/preloaded_assets.dart';

class LoadingSpinnger extends StatelessWidget {
  const LoadingSpinnger({super.key});

  @override
  Widget build(BuildContext context) {
    final composition = PreloadedAssets().loadingSpinner;

    return Center(
        child: Lottie(
      composition: composition,
      width: 200,
      height: 200,
    ));
  }
}
