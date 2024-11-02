
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/fonts.dart';
import '../../../utils/status_bar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_package/pin_put.dart';
import 'bottom_sheet/bottom_sheet_verfied_code.dart';

class ScreenOtpBank extends StatelessWidget {
  int? phoneNumber;
  ScreenOtpBank({
    this.phoneNumber,
    super.key});

  @override
  Widget build(BuildContext context) {
    AppStatusBar.light();

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Get.back(),
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: Color(0xff4C6042),
            child: Icon(Icons.arrow_back, color: Colors.white,),
          ).marginSymmetric(
            horizontal: 10.sp,
            vertical: 10.sp,
          ),
        ),
        title: Text("Confirm", style: AppFontsStyle.profileAppBar,),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 15.sp,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Confirm code via phone number", style: TextStyle(
                fontSize: 20.sp,
                color: Color(0xff4C6042),
                fontWeight: FontWeight.w500,
              ),),
              Text(
                textAlign: TextAlign.start,
                "We sent a code via sms to your phone number +961 -XXX-X00, enter the code !", style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xff4C6042).withOpacity(.3),
                fontWeight: FontWeight.w500,
              ),).marginSymmetric(
                vertical: 5.sp,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(flex: 2),
                    Center(
                      child: PinPut(
                        textStyle: TextStyle(
                          color: Color(0xff4C6042),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        followingFieldDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 5,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        eachFieldHeight: 80.h,
                        eachFieldWidth: 60.w,
                        submittedFieldDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 10,
                              spreadRadius: 0.6,
                              offset: Offset(0, -5)
                            ),
                          ],
                        ),
                        selectedFieldDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.normal,
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 10,
                                spreadRadius: 0.6,
                                offset: Offset(0, -5)
                            ),
                          ],
                        ),
                        cursorColor: Colors.black,
                        fieldsCount: 4,
                      ).marginSymmetric(
                        horizontal: 15.sp,
                      ),
                    ),
                    Spacer(),
                    RichText(
                      text: TextSpan(
                        text: "This code will expire in",
                        style: AppFontsStyle.forgotFonts,
                        children: [
                          TextSpan(
                            text: " 5 minutes",
                            style: AppFontsStyle.forgotFonts,
                          ),
                        ],
                      ),
                    ).marginOnly(
                      top: 20.sp,
                    ),
                    Spacer(flex: 2),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        children: [
                          CustomButton(
                            onTap: () {
                              OtpVerifiedSuccessful.show(context);
                            },
                            text: "VERIFY CODE",
                            textColor: Colors.white,
                            buttonColor: Colors.black,
                          ),
                          CustomButton(
                            onTap: () {
                              /// for testing
                              // Get.to(ScreenPhone());
                            },
                            text: "RESEND CODE",
                            textColor: Colors.white,
                            buttonColor: Colors.grey,
                          ).marginOnly(
                            top: 10.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).marginSymmetric(
                  vertical: 30.h,
                ),
              ),
            ],
          ).marginSymmetric(
            vertical: 10.sp,
            horizontal: 15.sp,
          ),
        ),
      ),
    );
  }
}
