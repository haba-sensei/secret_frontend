import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';
import 'package:tu_agenda_ya/global/service/store_service.dart';

class StoresController extends GetxController {
  var logger = Logger();
  final Location _location = Location();
  final _storeService = StoreService();

  var isLoading = true.obs;
  var errorMessage = ''.obs;

  var userLocation = LatLng(0.0, 0.0).obs;
  var stores = <Map<String, dynamic>>[].obs;
  var polygonPoints = <LatLng>[].obs;

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

  final MapController mapController = MapController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await _getUserLocation();
    await cargarDepartamentosYDistritos();

    // Selección por defecto Lima para departamento y provincia
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

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        errorMessage.value = 'Servicio de ubicación no habilitado.';
        return;
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        errorMessage.value = 'Permiso de ubicación denegado.';
        return;
      }
    }

    LocationData locationData = await _location.getLocation();
    userLocation.value =
        LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
  }

  Future<void> loadStoresMap({
    Map<String, double>? bounds,
    List<int>? typeStoreIds,
  }) async {
    try {
      final result = await _storeService.getStoresMap(
        bounds: bounds,
        typeStoreIds: typeStoreIds,
      );
      stores.assignAll(result);
    } catch (e) {
      errorMessage.value = 'Error al cargar negocios: $e';
    }
  }

  Future<void> centerMapOnUser() async {
    await _getUserLocation();
    mapController.move(userLocation.value, 15.0);
  }

  Future<void> clearMap() async {
    await _getUserLocation();
    mapController.move(userLocation.value, 10.0);
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
    mapController.move(center, 12);

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
