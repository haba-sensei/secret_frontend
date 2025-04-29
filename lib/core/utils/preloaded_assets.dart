import 'package:lottie/lottie.dart';

class PreloadedAssets {
  static final PreloadedAssets _instance = PreloadedAssets._internal();
  factory PreloadedAssets() => _instance;
  PreloadedAssets._internal();

  LottieComposition? loginLottie;
  LottieComposition? successLottie;
  LottieComposition? errorLottie;
  LottieComposition? loadingSpinner;

  Future<void> preloadAll() async {
    loginLottie = await AssetLottie('assets/loading_home2.json').load();
    successLottie = await AssetLottie('assets/success_apointment.json').load();
    errorLottie = await AssetLottie('assets/error_apointment.json').load();
    loadingSpinner = await AssetLottie('assets/spinner.json').load();
  }
}
