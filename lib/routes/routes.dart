import 'package:tu_agenda_ya/modules/chat/views/chat_page.dart';
import 'package:tu_agenda_ya/modules/favoritos/views/favoritos_page.dart';
import 'package:tu_agenda_ya/modules/home/views/home_page.dart';
import 'package:tu_agenda_ya/modules/booking/views/booking_page.dart';
import 'package:tu_agenda_ya/modules/notifications/views/notification_page.dart';
import 'package:tu_agenda_ya/modules/payments/views/payments_page.dart';
import 'package:tu_agenda_ya/modules/stores/views/stores_list_page.dart';
import 'package:tu_agenda_ya/modules/stores/views/stores_map_page.dart';
import 'package:tu_agenda_ya/modules/stores/views/stores_page.dart';
import 'package:tu_agenda_ya/modules/users/views/login_page.dart';
import 'package:tu_agenda_ya/modules/users/views/logout_page.dart';
import 'package:tu_agenda_ya/modules/users/views/onboarding_page.dart';
import 'package:tu_agenda_ya/modules/users/views/settings_page.dart';
import 'package:tu_agenda_ya/routes/routes_names.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage<dynamic>> appRoutes = <GetPage<dynamic>>[
    GetPage<OnboardingPage>(
      name: Routes.onboarding,
      page: () => const OnboardingPage(),
      transition: Transition.noTransition,
    ),
    GetPage<LoginPage>(
      name: Routes.login,
      page: () => const LoginPage(),
      transition: Transition.noTransition,
    ),
    GetPage<SettingsPage>(
      name: Routes.settings,
      page: () => const SettingsPage(),
      transition: Transition.noTransition,
    ),
    GetPage<LogoutPage>(
      name: Routes.logout,
      page: () => const LogoutPage(),
      transition: Transition.noTransition,
    ),
    GetPage<HomePage>(
      name: Routes.home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage<BookingPage>(
      name: Routes.booking,
      page: () => const BookingPage(),
      transition: Transition.noTransition,
    ),
    GetPage<NotificationPage>(
      name: Routes.notifications,
      page: () => const NotificationPage(),
      transition: Transition.noTransition,
    ),
    GetPage<ChatPage>(
      name: Routes.chat,
      page: () => const ChatPage(),
      transition: Transition.noTransition,
    ),
    GetPage<StoresPage>(
      name: Routes.stores,
      page: () => const StoresPage(),
      transition: Transition.noTransition,
    ),
    GetPage<PaymentsPage>(
      name: Routes.payments,
      page: () => const PaymentsPage(),
      transition: Transition.noTransition,
    ),
    GetPage<FavoritosPage>(
      name: Routes.favoritos,
      page: () => const FavoritosPage(),
      transition: Transition.fadeIn,
    ),
    GetPage<StoresMapPage>(
      name: Routes.storesMap,
      page: () => const StoresMapPage(),
      transition: Transition.fadeIn,
    ),
    GetPage<StoresListPage>(
      name: Routes.storesList,
      page: () => const StoresListPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
