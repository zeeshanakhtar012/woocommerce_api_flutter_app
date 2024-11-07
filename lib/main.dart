import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zrj/utils/app_translation.dart';
import 'package:zrj/views/screens/splash_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    String locale = box.read('language') ?? 'en_US';
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            final ThemeData lightTheme = ThemeData(
              useMaterial3: false,
              fontFamily: 'Avenir',
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
              ),
              brightness: Brightness.light,
              primaryColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
            );

            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: AppTranslations(), // Translation setup
              locale: Locale(locale.split('_')[0], locale.split('_')[1]), // Load saved locale
              fallbackLocale: const Locale('en', 'US'),
              theme: lightTheme,
              home: SplashScreen(), // Starting screen (SplashScreen can navigate to LanguageSelectionScreen)
              defaultTransition: Transition.fadeIn,
              transitionDuration: const Duration(milliseconds: 500),
              builder: (context, child) {
                final mediaQueryData = MediaQuery.of(context);
                final scale = mediaQueryData.textScaleFactor.clamp(0.8, 0.9);
                return MediaQuery(
                  data: mediaQueryData.copyWith(textScaleFactor: scale),
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
