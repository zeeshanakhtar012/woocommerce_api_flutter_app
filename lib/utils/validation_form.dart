
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bool isEmailValid(String? email) {
      if (email == null || email.isEmpty) return false;
      final regExp = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        caseSensitive: false,
      );
      return regExp.hasMatch(email);
    }

    bool isNameValid(String? name) {
      if (name == null || name.isEmpty) return false;
      final regExp = RegExp(
        r"^[a-zA-Z\s]{2,}$",
        caseSensitive: false,
      );
      return regExp.hasMatch(name);
    }

    bool isPasswordValid(String? password) {
      if (password == null || password.isEmpty || password.length < 8)
        return false;
      else
        return true;
    }

    bool isConfirmPasswordValid(String? password, String? confirmPassword) {
      if (password == null || confirmPassword == null) return false;
      return password == confirmPassword;
    }

 
   void showQuickAlert(String description, {String title = "Error"}) {
    Get.snackbar(
      title,
      description,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(vertical: 35.h, horizontal: 15.w),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      icon: const Icon(Icons.error, color: Colors.white),
      shouldIconPulse: true,
      // leftBarIndicatorColor: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
    );
  }
