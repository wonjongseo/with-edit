import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:with_diet/views/splash/splash_screen.dart';
import 'firebase_options.dart';

// com.wonjongseo.with-diet
// dart run change_app_package_name:main com.wonjongseo.with-diet∏
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      fallbackLocale: const Locale('ko', 'KR'),
      // translations: AppTranslations(),
      locale: Locale(Get.deviceLocale.toString()),
      debugShowCheckedModeBanner: false,
      title: 'With diet',
      home: const SplashScreen(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
