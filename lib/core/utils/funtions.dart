import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tu_agenda_ya/core/utils/shared_pref.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, Map<String, List<Map<String, dynamic>>>>>
    loadDistrictsFromJson() async {
  final String data = await rootBundle.loadString('assets/distritos.json');
  final Map<String, dynamic> jsonResult = jsonDecode(data);

  return jsonResult.map((depKey, provMap) {
    final provinciaParsed =
        (provMap as Map<String, dynamic>).map((provKey, distritoList) {
      final List<Map<String, dynamic>> distritos = (distritoList as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      return MapEntry(provKey, distritos);
    });
    return MapEntry(depKey, provinciaParsed);
  });
}



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

final Map<int, IconData> typeStoreIconsById = {
  1: Icons.cut,
  2: Icons.face_retouching_natural,
  3: Icons.spa,
  4: Icons.pets,
  5: Icons.restaurant,
  6: Icons.health_and_safety,
  7: Icons.brush,
  8: Icons.handshake,
};

Color? parseColor(String? color) {
  if (color == null || color.length != 6) return null;
  try {
    return Color(int.parse('0xFF$color'));
  } catch (_) {
    return null;
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371.0;
  final dLat = _deg2rad(lat2 - lat1);
  final dLon = _deg2rad(lon2 - lon1);
  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return earthRadius * c;
}

double _deg2rad(double deg) => deg * (pi / 180);

String estimateTime(double distanceKm) {
  const avgSpeedKmPerMin = 0.33; // 30 km/h
  final minutes = (distanceKm / avgSpeedKmPerMin).round();
  return '$minutes min';
}
