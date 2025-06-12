import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';
import 'package:tu_agenda_ya/global/service/store_service.dart';
import 'package:tu_agenda_ya/modules/home/controller/home_controller.dart';

class StoresController extends GetxController {
  final homeController = Get.find<HomeController>();
  var logger = Logger();
  final _storeService = StoreService();
  final _locationService = Location();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var userLocation = LatLng(0.0, 0.0).obs;
  var stores = <Map<String, dynamic>>[].obs;
  var selectedStoreId = Rxn<int>();
  var polygonPoints = <LatLng>[].obs;
  var routePoints = <LatLng>[].obs;

  var departamentos = <String>[].obs;

  var distritosPorDepartamento =
      <String, Map<String, List<Map<String, dynamic>>>>{}.obs;

  var distritosFiltrados = <Map<String, dynamic>>[].obs;

  var departamentoSeleccionado = ''.obs;
  var distritoSeleccionado = <String, dynamic>{}.obs;

  var provinciasPorDepartamento = <String, List<String>>{}.obs;
  var provinciaSeleccionada = ''.obs;

  var tiposDeServicios = <Map<String, dynamic>>[].obs;
  var serviciosSeleccionados = <int>[].obs;

  var detailStoreView = Rxn<Map<String, dynamic>>();

  final animatedStoreIds = <int>{}.obs;

  final MapController mapController = MapController();

  @override
  Future<void> onInit() async {
    super.onInit();
    final loc = homeController.currentLocation;
    if (loc != null) {
      userLocation.value = LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0);
    }
    await cargarDepartamentosYDistritos();
    if (departamentos.contains('Lima')) {
      seleccionarDepartamento('Lima');

      if (provinciasPorDepartamento['Lima']?.contains('Lima') ?? false) {
        seleccionarProvincia('Lima');
      }
    }

    if (tiposDeServicios.isEmpty) {
      await cargarTipoServicios();
    }
    isLoading.value = false;
  }

  Future<void> loadStoresMap({
    Map<String, double>? bounds,
    List<int>? typeStoreIds,
    List<Map<String, double>>? coords,
  }) async {
    try {
      final currentLocation = await _locationService.getLocation();
      final lat0 = currentLocation.latitude!;
      final lon0 = currentLocation.longitude!;

      final result = await _storeService.getStoresMap(
        bounds: bounds,
        typeStoreIds: typeStoreIds,
        coords: coords,
      );

      for (var store in result) {
        final geo = store['geolocation'] as String?;
        if (geo != null && geo.contains(',')) {
          final parts = geo.split(',');
          final lat = double.tryParse(parts[0]);
          final lon = double.tryParse(parts[1]);

          if (lat != null && lon != null) {
            final d = calculateDistance(lat0, lon0, lat, lon);
            store['distance'] = d;
            store['estimatedTime'] = estimateTime(d);
          }
        }
      }

      stores.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Error al cargar negocios: $e';
    }
  }


  Future<void> centerMapOnUser() async {
    final loc = homeController.currentLocation;
    if (loc != null) {
      userLocation.value = LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0);
      mapController.move(userLocation.value, 15.0);
    } else {
      errorMessage.value = 'Ubicación del usuario no disponible';
    }
  }

  Future<void> clearMap() async {
    final loc = homeController.currentLocation;
    if (loc != null) {
      userLocation.value = LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0);
      polygonPoints.clear();
      serviciosSeleccionados.clear();
      stores.clear();
      mapController.move(userLocation.value, 10.0);
    } else {
      errorMessage.value = 'Ubicación del usuario no disponible';
    }
  }

  Future<void> cargarDepartamentosYDistritos() async {
    final raw = await loadDistrictsFromJson();

    distritosPorDepartamento.value = raw;

    departamentos.assignAll(raw.keys);

    provinciasPorDepartamento.value = {
      for (var dep in raw.keys) dep: raw[dep]!.keys.toList()
    };
  }

  void seleccionarDepartamento(String departamento) {
    departamentoSeleccionado.value = departamento;
    provinciaSeleccionada.value = '';
    distritosFiltrados.clear();
    distritoSeleccionado.clear();
  }

  void seleccionarProvincia(String provincia) {
    provinciaSeleccionada.value = provincia;

    final distritoList =
        distritosPorDepartamento[departamentoSeleccionado.value]?[provincia] ??
            [];

    distritosFiltrados.assignAll(distritoList);
    distritoSeleccionado.clear();
  }

  void filtrarDistritos(String query) {
    final provincia = provinciaSeleccionada.value;
    final distritoList =
        distritosPorDepartamento[departamentoSeleccionado.value]?[provincia] ??
            [];

    if (query.isEmpty) {
      distritosFiltrados.assignAll(distritoList);
    } else {
      distritosFiltrados.assignAll(distritoList
          .where((distrito) =>
              distrito['distrito'].toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  Future<void> aplicarFiltro({
    required List<LatLng> coordenadas,
    required List<int> serviceIds,
  }) async {
    polygonPoints.assignAll(coordenadas);

    final center = _calcularCentro(coordenadas);
    mapController.move(center, 14);

    final coordsJson = coordenadas
        .map((coord) => {
              'lat': coord.latitude,
              'lng': coord.longitude,
            })
        .toList();

    final latitudes = coordenadas.map((p) => p.latitude);
    final longitudes = coordenadas.map((p) => p.longitude);
    final minLat = latitudes.reduce((a, b) => a < b ? a : b);
    final maxLat = latitudes.reduce((a, b) => a > b ? a : b);
    final minLng = longitudes.reduce((a, b) => a < b ? a : b);
    final maxLng = longitudes.reduce((a, b) => a > b ? a : b);
    await loadStoresMap(
      bounds: {
        'min_lat': minLat,
        'max_lat': maxLat,
        'min_lng': minLng,
        'max_lng': maxLng,
      },
      typeStoreIds: serviceIds,
      coords: coordsJson
    );
  }

  LatLng _calcularCentro(List<LatLng> puntos) {
    if (puntos.isEmpty) return const LatLng(0, 0);

    double latSum = 0;
    double lngSum = 0;

    for (var punto in puntos) {
      latSum += punto.latitude;
      lngSum += punto.longitude;
    }

    return LatLng(latSum / puntos.length, lngSum / puntos.length);
  }

  void limpiarDistritoSeleccionado() {
    distritoSeleccionado.clear();
  }

  Future<void> cargarTipoServicios() async {
    try {
      final result = await _storeService.getTypeStores();
      tiposDeServicios.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Error al cargar servicios: $e';
    }
  }

  void toggleServicioSeleccionado(int servicioId) {
    if (serviciosSeleccionados.contains(servicioId)) {
      serviciosSeleccionados.remove(servicioId);
    } else {
      serviciosSeleccionados.add(servicioId);
    }
  }
}
