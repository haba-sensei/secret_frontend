import 'package:tu_agenda_ya/core/utils/shared_pref.dart';
import 'package:tu_agenda_ya/global/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tu_agenda_ya/global/widgets/custom_spinner.dart';

final SupabaseClient supabase = Supabase.instance.client;

class UsersController extends GetxController {
  final SharedPref _sharedPref = SharedPref();
  var logger = Logger();

  Future<void> loginGoogle() async {
    try {
      final String webClientId = dotenv.env['SUPABASE_WEB_CLIENT_ID']!;
      final String iosClientId = dotenv.env['SUPABASE_IOS_CLIENT_ID']!;

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: iosClientId,
        serverClientId: webClientId,
      );

      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        Get.snackbar(
          "Inicio de sesión cancelado",
          "No se completó el inicio de sesión con Google.",
        );
        return;
      }

      customSpinner();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw Exception('No se encontraron tokens de acceso o ID.');
      }

      final AuthResponse response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.session != null) {
        await _sharedPref.save('user', response.user?.toJson());

        if (response.user?.userMetadata != null) {
          final avatarUrl = response.user?.userMetadata!['avatar_url'];
          if (avatarUrl != null) {
            await _sharedPref.saveAvatarImage(avatarUrl);
          }
        }

        GlobalController().onInit();
        _sharedPref.checkSessionStatus();
      } else {
        throw Exception('No se pudo iniciar sesión en Supabase.');
      }
    } catch (e) {
      Get.snackbar(
          "Error de inicio de sesión", "Ha ocurrido un error: ${e.toString()}",
          duration: const Duration(seconds: 10));
    }
  }
}
