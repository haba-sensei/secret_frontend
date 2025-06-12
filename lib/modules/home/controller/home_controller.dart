import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:location/location.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';
import 'package:tu_agenda_ya/global/model/slider_model.dart';
import 'package:tu_agenda_ya/global/model/store_model.dart';
import 'package:tu_agenda_ya/global/service/store_service.dart';

class HomeController extends GetxController {
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  final sliders = <SliderModel>[
    SliderModel(position: 1, title: 'Barberías más cercanas', stores: []),
    SliderModel(position: 2, title: 'Peluquerías más cercanas', stores: []),
    SliderModel(position: 3, title: 'Spas más cercanos', stores: []),
  ].obs;

  LocationData? currentLocation;
  final _locationService = Location();
  final StoreService _service = StoreService();
  final Logger _logger = Logger();
  final servicios = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    cargarTipoServicios();
    _initLocationAndLoadSliders();
  }

  Future<void> _initLocationAndLoadSliders() async {
    try {
      isLoading.value = true;

      // Verifica permisos de ubicación
      if (!await _locationService.serviceEnabled() &&
          !(await _locationService.requestService())) {
        errorMessage.value = 'Servicio de ubicación no habilitado';
        return;
      }
      if (await _locationService.hasPermission() == PermissionStatus.denied &&
          await _locationService.requestPermission() !=
              PermissionStatus.granted) {
        errorMessage.value = 'Permiso de ubicación denegado';
        return;
      }
      currentLocation = await _locationService.getLocation();
      final lat0 = currentLocation!.latitude!;
      final lon0 = currentLocation!.longitude!;
      await _loadSliders(lat0, lon0);
    } catch (e) {
      errorMessage.value = 'Error obteniendo ubicación: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadSliders(double lat0, double lon0) async {
    try {
      final fetched = await _service.fetchSliders(
        latitude: lat0,
        longitude: lon0,
      );

      for (var slider in fetched) {
        for (var store in slider.stores) {
          final geo = store.geolocation;
          if (geo != null && geo.contains(',')) {
            final parts = geo.split(',');
            final lat = double.tryParse(parts[0]);
            final lon = double.tryParse(parts[1]);
            if (lat != null && lon != null) {
              final d = calculateDistance(lat0, lon0, lat, lon);
              store.distance = d;
              store.estimatedTime = estimateTime(d);
            }
          }
        }
        // Ordena por distancia y limita a 10
        slider.stores
            .sort((a, b) => (a.distance ?? 0).compareTo(b.distance ?? 0));
        if (slider.stores.length > 10) {
          slider.stores = List<StoreModel>.from(slider.stores.take(10));
        }
      }

      // Asignar sliders cargados
      sliders.assignAll(fetched);
    } catch (e, st) {
      _logger.e('Error loadSliders', error: e, stackTrace: st);
      errorMessage.value = 'Error cargando sliders: $e';
    }
  }

  Future<void> cargarTipoServicios() async {
    try {
      final result = await _service.getTypeStores();
      servicios.assignAll(result.map((item) {
        final id = item['id'] as int;
        return {
          'id': id,
          'label': item['name'],
          'icon': typeStoreIconsById[id] ?? Icons.store,
        };
      }));
    } catch (e) {
      errorMessage.value = 'Error al cargar servicios: $e';
    }
  }

}
