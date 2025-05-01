import 'package:tu_agenda_ya/core/utils/shared_pref.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';

Future<String> determineInitialRoute() async {
  final SharedPref sharedPref = SharedPref();

  final isFirstLaunch = await sharedPref.read('isFirstLaunch');
  if (isFirstLaunch == null || isFirstLaunch == true) {
    await sharedPref.save('isFirstLaunch', false);
    return Routes.onboarding;
  }

  final user = await sharedPref.read('user');
  if (user == null) {
    return Routes.login;
  }

  return Routes.home;
}
