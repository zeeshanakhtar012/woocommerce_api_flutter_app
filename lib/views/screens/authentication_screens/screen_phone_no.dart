import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';

class ScreenPhone extends StatelessWidget {
  const ScreenPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerRight,
                  image: AssetImage(
                    "assets/images/sign_in_logo_png.png",
                  ),
                ),
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(35),
                  bottomLeft: Radius.circular(35),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 14.sp,
                      horizontal: 15.sp,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "enter_your_phone".tr, // Use translation key
                          style: AppFontsStyle.logInTitle,
                        ),
                        Text(
                          "enter_your_phone_number_to_verify".tr, // Use translation key
                          textAlign: TextAlign.start,
                          style: AppFontsStyle.logInSubtitle,
                        ).marginSymmetric(vertical: 10.sp),
                      ],
                    ).marginOnly(
                      top: 50.sp,
                      right: 100.sp,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 30.h,
                horizontal: 15.w,
              ),
              child: MyInputField(
                hint: "enter_phone_number".tr, // Use translation key
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.sp,
                vertical: 60.sp,
              ),
              child: CustomButton(
                onTap: () {},
                text: "save_phone_number".tr, // Use translation key
                textColor: Colors.white,
                buttonColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
