import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final box = GetStorage();

  void changeLanguage(String langCode) {
    var locale = Locale(langCode.split('_')[0], langCode.split('_')[1]);
    Get.updateLocale(locale);
    box.write('language', langCode); // Save selected language
  }
}
