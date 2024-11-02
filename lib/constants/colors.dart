import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static Color buttonColor = Color(0xff000000);
  static Color whiteColor = Color(0xffF4F4F4);
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.black.withOpacity(.12),
    blurStyle: BlurStyle.outer,
    // offset: Offset(-0.4, -0.8),
    blurRadius: 8,
    spreadRadius: 0,
  );
  static Color appPrimaryColor = Color(0xff002654);
  static Color appGreyColor = Color(0xffA7A7A7);
  static Color appRedColor = Color(0xFFED2939);
  static BoxShadow boxShadowCheckout = BoxShadow(
    color: Colors.black.withOpacity(.12),
    blurStyle: BlurStyle.outer,
    // offset: Offset(-0.4, -0.8),
    blurRadius: 10,
    spreadRadius: .0,
  );
  static BoxShadow inputField = BoxShadow(
    color: Colors.black.withOpacity(.07),
    blurStyle: BlurStyle.outer,
    // offset: Offset(-0.4, -0.8),
    blurRadius: 10,
    spreadRadius: .0,
  );
  static BoxShadow paymentContainerShadow = BoxShadow(
    color: Colors.black.withOpacity(.12),
    blurStyle: BlurStyle.outer,
    // offset: Offset(-0.4, -0.8),
    blurRadius: 10,
    spreadRadius: 0,
  );
  static BoxShadow myCustomBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(.1),
    blurRadius: 4, // Softer shadow
    spreadRadius: 0, // Less spread
    offset: Offset(0, 2),
  );
}
