import 'package:logger/logger.dart';
import 'package:tu_agenda_ya/core/utils/shared_pref.dart';
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
}
