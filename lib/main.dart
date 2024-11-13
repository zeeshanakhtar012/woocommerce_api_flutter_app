import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:zrj/utils/app_translation.dart';
import 'package:zrj/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe with a publishable key before applying settings
  Stripe.publishableKey = "pk_test_51QK3OSKuV05bCvMeTcEqLo612iOCFZ8B3CG5BVRgG6nycWMX0VkhhZnaumh7W3uBTzyDdT7CNm8NjM8uF1yRgToW00IxYTH05s";

  // Apply additional Stripe settings with error handling
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  try {
    await Stripe.instance.applySettings();
  } catch (e) {
    print("Stripe configuration error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = GetStorage(); // initialize GetStorage to read saved locale

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
              translations: AppTranslations(),
              locale: Locale(locale.split('_')[0], locale.split('_')[1]),
              fallbackLocale: const Locale('en', 'US'),
              theme: lightTheme,
              home: SplashScreen(),
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
