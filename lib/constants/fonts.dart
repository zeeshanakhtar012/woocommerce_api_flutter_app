import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'colors.dart';
class AppFontsStyle {

  static TextStyle introScrTitle = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'AvenirHeavy',
    color: Color(0xff002654),
    fontWeight: FontWeight.w700,
  );
  static TextStyle introScrSubtitle= TextStyle(
    fontSize: 14.sp,
    fontFamily: 'AvenirLight',
    color: Color(0xff002654),
    fontWeight: FontWeight.w400,
  );
  static TextStyle loginOption= TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Avenir',
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static TextStyle logInTitle = TextStyle(
    fontSize: 30.sp,
    fontFamily: 'Avenir',
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle logInSubtitle = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Avenir',
    color: Colors.white30,
    fontWeight: FontWeight.w400,
  );
  static TextStyle profileName = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Avenir',
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle profileEmail = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Avenir',
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );
  static TextStyle profileDetails = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Avenir',
    color: Color(0xff002654),
    fontWeight: FontWeight.w600,
  );
  static TextStyle profileAppBar = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Avenir',
    color: Color(0xff002654),
    fontWeight: FontWeight.w600,
  );
  static TextStyle profileTitle = TextStyle(
    fontSize: 20.sp,
    fontFamily: 'Avenir',
    color: Color(0xff002654),
    fontWeight: FontWeight.w600,
  );
  static TextStyle forgotFonts = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Avenir',
    color: AppColors.appGreyColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle forgotFontsDark = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Avenir',
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle editButton = TextStyle(
    fontSize: 12.sp,
    fontFamily: 'Avenir',
    color: Color(0xff002654),
    fontWeight: FontWeight.w300,
  );
 static InkWell buildBackButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child:Container(
        height: 37.h,
        width: 37.w,
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff002654),
        ),
        child: SvgPicture.asset("assets/icons/back-button.svg"),
      ),
    );
  }
}