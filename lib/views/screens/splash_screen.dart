import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zrj/constants/colors.dart';
import 'package:zrj/views/screens/authentication_screens/screen_login.dart';
import 'package:zrj/views/home/home_screen.dart';
import 'package:zrj/views/screens/authentication_screens/screen_signup.dart';

import '../../controllers/controller_authentication.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ControllerAuthentication authController = Get.put(ControllerAuthentication());

  @override
  void initState() {
    super.initState();
    _checkAuthenticationStatus();
  }

  // Check if user is authenticated
  _checkAuthenticationStatus() async {
    await Future.delayed(Duration(seconds: 3));  // Simulate the splash screen delay

    bool isAuthenticated = await authController.isAuthenticated();  // Check if authenticated

    if (isAuthenticated) {
      Get.offAll(HomeScreen());
    } else {
      Get.offAll(ScreenLogin());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Container(
          height: 124.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/final  ZRJ.png"),
            ),
          ),
        ).marginOnly(left: 71.w, right: 70.w),
      ),
    );
  }
}
