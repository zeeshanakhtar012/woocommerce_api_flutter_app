import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

class CustomTextFieldSearch extends StatelessWidget {
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
  final ValueChanged<String>? onChanged; // New parameter

  CustomTextFieldSearch({
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
    this.borderRadius = 20.0,
    this.readOnly = false,
    this.onTap,
    this.onChanged, // Add new parameter to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.all(8.0),
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            blurRadius: 10,  // Softer shadow
            spreadRadius: 0, // Less spread
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged, // Use the onChanged parameter here
          style: TextStyle(
            color: Color(0xff4C6042),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(.6),
            ),
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            isDense: isDense,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
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
          ),
        ),
      ),
    );
  }
}
