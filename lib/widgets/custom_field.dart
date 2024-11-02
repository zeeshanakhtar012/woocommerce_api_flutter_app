import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final double? height;
  final double? width;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool isDense;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function(String)? onChanged; // Added onChanged parameter

  CustomTextField({
    this.controller,
    this.width,
    this.height,
    required this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.isDense = false,
    this.contentPadding,
    this.borderRadius = 50.0,
    this.readOnly = false,
    this.onTap,
    this.onChanged, // Initialize onChanged parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //   left: 15.sp,
      // ),
      width: width,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      // height: 62.h,
      decoration: BoxDecoration(
         color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            AppColors.myCustomBoxShadow
          ]
      ),
      child: Center(
        child: TextFormField(
          
          cursorColor: AppColors.appPrimaryColor,
          style: TextStyle(
             color: Color(0xff4C6042),
            fontWeight: FontWeight.w600,
            fontSize: 14.sp
          ),
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged, // Add onChanged to TextFormField
          decoration: InputDecoration(
            
            fillColor: Color(0xFFFFFFFF),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Color(0xffA7A7A7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w300
            ),
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: isDense,
            contentPadding: contentPadding ?? EdgeInsets.only(top: 30.h, bottom: 30.h, left: 25.w, right: 10.w),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
              errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Colors.red
              ),
            ),
          ),
        ),
      ),
    );
  }
}
