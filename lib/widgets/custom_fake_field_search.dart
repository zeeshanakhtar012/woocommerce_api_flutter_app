import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class CustomFakeFieldSearch extends StatelessWidget {
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
  final VoidCallback? onChanged;

  CustomFakeFieldSearch({
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
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.only(right: 10.w),
        height: 38.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 4, // Softer shadow
              spreadRadius: 0, // Less spread
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Text(
                  'Search',
                  style: TextStyle(
                      color: AppColors.appGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300),
                ),
              ),

              GestureDetector(
                onTap: onChanged,
                child: Container(
                  height: Get.height,
                  width: 51.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff4C6042),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
