import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStatusBar {
  static light() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Set icon brightness to dark
      statusBarBrightness: Brightness.light, // For iOS, use light for dark text
      systemNavigationBarColor: Colors.white, // Navigation bar color
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static dark() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Colors.black, // Set the status bar background color to black
      statusBarIconBrightness:
          Brightness.light, // Set icon brightness to light (white)
      statusBarBrightness:
          Brightness.dark, // For iOS, use dark to show light text
      systemNavigationBarColor: Colors.black, // Navigation bar color
      systemNavigationBarIconBrightness:
          Brightness.light, // Set navigation bar icons to light
    ));
  }
}
