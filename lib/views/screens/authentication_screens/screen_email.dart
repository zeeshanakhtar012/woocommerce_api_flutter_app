import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';

class ScreenEmail extends StatelessWidget {
  ScreenEmail({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 226.h,
                width: double.infinity,
                padding: EdgeInsets.only(right: 22.w, bottom: 22.h, top: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -250,
                      top: 10.h,
                      child: SvgPicture.asset(
                        "assets/icons/spiral.svg",
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: SvgPicture.asset("assets/icons/back-button.svg"),
                        ).marginOnly(bottom: 48.h),
                        Text(
                          "enter_your_email".tr,  // Use translation key
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ).marginOnly(bottom: 11.h),
                        Text(
                          "provide_email_address".tr,  // Use translation key
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            height: 2.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ).marginOnly(bottom: 1.h)
                      ],
                    ).marginSymmetric(horizontal: 32.w),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "your_email_address".tr,  // Use translation key
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'please_enter_valid_email'.tr;  // Use translation key
                          }
                          return null;
                        },
                      ),
                    ),
                    Spacer(flex: 1),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Add your logic to send the code
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                          ),
                          child: Text(
                            "send_code".tr,  // Use translation key
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ).marginSymmetric(horizontal: 32.w),
                  ],
                ).marginSymmetric(vertical: 30.h),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
