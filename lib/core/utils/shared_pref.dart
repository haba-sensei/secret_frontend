import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tu_agenda_ya/core/utils/medias_query.dart';
import 'package:tu_agenda_ya/global/widgets/custom_spinner.dart';
import 'package:tu_agenda_ya/modules/users/model/user_model.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

class SharedPref {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> save(String key, value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) {
      return null;
    }

    String? obj = prefs.getString(key);

    return json.decode(obj!);
  }

  Future<bool> contains(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  logout() async {
    customSpinner();
    await remove('user');
    await supabase.auth.signOut();
    Get.back();
    checkSessionStatus();
  }

  messageHandle(String tipo, String mensaje, Color color) async {
    Get.isSnackbarOpen
        ? null
        : Get.snackbar(
            'Detalle del $tipo: ',
            mensaje,
            backgroundColor: color,
            colorText: Colors.white,
            snackStyle: SnackStyle.FLOATING,
            isDismissible: true,
            margin: const EdgeInsets.only(top: 20),
            maxWidth: MyMediaQuery.messageWidth,
            icon: const Icon(
              Icons.error_outlined,
              size: 37,
              color: Colors.white,
            ),
            onTap: (_) => Get.back(),
            shouldIconPulse: true,
            snackPosition: SnackPosition.TOP,
          );
  }

  checkSessionStatus() async {
    UserModel user = UserModel.fromJson(await read('user') ?? {});

    if (user.id == null) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.home);
    }
  }

  Future<void> saveAvatarImage(String avatarUrl) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(avatarUrl));

    if (response.statusCode == 200) {
      String base64Image = base64Encode(response.bodyBytes);
      await prefs.setString('user_avatar', base64Image);
    } else {
      throw Exception('No se pudo descargar la imagen de avatar');
    }
  }

  Future<ImageProvider> getAvatarImageProvider() async {
    final prefs = await SharedPreferences.getInstance();
    final base64Image = prefs.getString('user_avatar');

    if (base64Image != null) {
      Uint8List bytes = base64Decode(base64Image);
      return MemoryImage(bytes);
    } else {
      return const AssetImage('assets/240-1.png');
    }
  }
}
