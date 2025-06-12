import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';
import 'package:tu_agenda_ya/core/utils/shared_pref.dart';
import 'package:tu_agenda_ya/global/model/store_model.dart';
import 'package:tu_agenda_ya/modules/users/model/user_model.dart';

class FavoritosController extends GetxController {
  final SharedPref _sharedPref = SharedPref();
  final Location _locationService = Location();

  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var favoritos = <StoreModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavoritos();
  }

  Future<void> loadFavoritos() async {
    try {
      isLoading.value = true;

      final user = UserModel.fromJson(await _sharedPref.read('user') ?? {});
      if (user.id == null) {
        errorMessage.value = 'Usuario no logueado';
        return;
      }

      // Obtener favoritos
      final key = 'favorites_user_${user.id}';
      final List<dynamic> data = await _sharedPref.read(key) ?? [];
      final stores = data
          .map((item) => StoreModel.fromJson(item as Map<String, dynamic>))
          .toList();

      // Obtener ubicación actual
      if (!await _locationService.serviceEnabled()) {
        await _locationService.requestService();
      }
      if (await _locationService.hasPermission() == PermissionStatus.denied) {
        await _locationService.requestPermission();
      }
      final currentLocation = await _locationService.getLocation();
      final lat0 = currentLocation.latitude;
      final lon0 = currentLocation.longitude;

      // Recalcular distancia y tiempo
      for (var store in stores) {
        final geo = store.geolocation;
        if (geo != null && geo.contains(',')) {
          final parts = geo.split(',');
          final lat = double.tryParse(parts[0]);
          final lon = double.tryParse(parts[1]);

          if (lat != null && lon != null && lat0 != null && lon0 != null) {
            final d = calculateDistance(lat0, lon0, lat, lon);
            store.distance = d;
            store.estimatedTime = estimateTime(d);
          }
        }
      }

      favoritos.value = stores;
    } catch (e) {
      errorMessage.value = 'Error al cargar favoritos: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFavorite(StoreModel store) async {
    try {
      final user = UserModel.fromJson(await _sharedPref.read('user') ?? {});
      if (user.id == null) {
        errorMessage.value = 'Usuario no logueado';
        return;
      }

      final key = 'favorites_user_${user.id}';
      List<dynamic> favorites = await _sharedPref.read(key) ?? [];

      favorites.removeWhere((s) => s['id'] == store.id);

      await _sharedPref.save(key, favorites);
      loadFavoritos(); // Recarga favoritos con nueva distancia
    } catch (e) {
      errorMessage.value = 'Error al eliminar favorito: $e';
    }
  }
}
