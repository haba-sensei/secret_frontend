import 'package:flutter/services.dart';
import 'package:tu_agenda_ya/core/constant/const_texts.dart';
import 'package:tu_agenda_ya/core/utils/colors_style.dart';
import 'package:tu_agenda_ya/core/utils/preloaded_assets.dart';
import 'package:tu_agenda_ya/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tu_agenda_ya/core/utils/funtions.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  await PreloadedAssets().preloadAll();

  final initialRoute = await determineInitialRoute();

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: MyConst.titulo,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      getPages: AppPages.appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
