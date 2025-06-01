import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/core/utils/shared_pref.dart';
import 'package:tu_agenda_ya/global/model/store_model.dart';
import 'package:tu_agenda_ya/modules/users/model/user_model.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final SharedPref _sharedPref = SharedPref();
  Rx<UserModel> userLoad = Rx<UserModel>(UserModel());
  double drawerValue = 0;
  RxInt selectedPageIndex = 0.obs;
  var logger = Logger();

  @override
  onInit() async {
    var userJson = await _sharedPref.read('user');
    if (userJson != null) {
      userLoad.value = UserModel.fromJson(userJson);
    }
    super.onInit();
  }

  Future<void> userLogOut() async {
    await _sharedPref.logout();
    userLoad.value = UserModel();
    update();
  }

  void toggleDrawer() {
    drawerValue = drawerValue == 0 ? 1 : 0;
    update();
  }

  void closeDrawer() {
    drawerValue = 0;
    update();
  }

  String toTitleCase(String text) {
    return text.split(' ').map((str) {
      return str.isNotEmpty
          ? str[0].toUpperCase() + str.substring(1).toLowerCase()
          : '';
    }).join(' ');
  }

  void updatePageIndex(int index) {
    if (selectedPageIndex.value != index) {
      selectedPageIndex.value = index;
      update();
    }
  }

  Future<void> toggleFavorite(StoreModel store) async {
    final user = UserModel.fromJson(await _sharedPref.read('user') ?? {});
    if (user.id == null) return;

    final key = 'favorites_user_${user.id}';
    List<dynamic> favorites = await _sharedPref.read(key) ?? [];

    // Check si ya está en favoritos
    final exists = favorites.any((s) => s['id'] == store.id);

    if (exists) {
      favorites.removeWhere((s) => s['id'] == store.id);
    } else {
      logger.i(store.toJson());
      favorites.add(store.toJson());
    }

    await _sharedPref.save(key, favorites);
  }

  Future<bool> isFavorite(StoreModel store) async {
    final user = UserModel.fromJson(await _sharedPref.read('user') ?? {});
    if (user.id == null) return false;

    final key = 'favorites_user_${user.id}';
    List<dynamic> favorites = await _sharedPref.read(key) ?? [];
    return favorites.any((s) => s['id'] == store.id);
  }
}
