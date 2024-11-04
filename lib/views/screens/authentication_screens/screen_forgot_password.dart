import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_package/pin_put.dart';

class ScreenForgotPassword extends StatelessWidget {
  final String email;
  final bool isSignUp;

  ScreenForgotPassword({
    required this.email,
    required this.isSignUp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 226.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
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
                onPressed: () => Get.back(),
                icon: SvgPicture.asset("assets/icons/back-button.svg"),
              ).marginOnly(bottom: 48.h),
              Text(
                isSignUp ? "verify_your_email".tr : "forgot_password".tr,
                style: AppFontsStyle.logInTitle,
              ).marginOnly(bottom: 11.h),
              Text(
                isSignUp
                    ? "please_check_your_email_for_otp".tr
                    : "dont_worry_we_will_help_you_reset_it".tr,
                textAlign: TextAlign.start,
                style: AppFontsStyle.logInSubtitle.copyWith(color: Colors.white, height: 2.5),
              ).marginOnly(bottom: 2.h),
            ],
          ).marginSymmetric(horizontal: 32.w),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 1),
        Center(
          child: PinPut(
            controller: TextEditingController(),
            textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Color(0xff4C6042)),
            followingFieldDecoration: _fieldDecoration(),
            eachFieldHeight: 63.h,
            eachFieldWidth: 63.w,
            separator: SizedBox(width: 16.w),
            fieldsCount: 4,
          ),
        ),
        Spacer(flex: 2),
        _buildEmailInfo(),
        Spacer(flex: 2),
        _buildExpiryInfo(),
        Spacer(flex: 1),
        _buildActionButtons(),
      ],
    );
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      color: Color(0xFFF6F6F7),
      borderRadius: BorderRadius.circular(10),
    );
  }

  Widget _buildEmailInfo() {
    return Column(
      children: [
        Text("code_was_sent_to_your_email".tr, style: AppFontsStyle.forgotFonts),
        Text(
          email,
          style: AppFontsStyle.forgotFontsDark.copyWith(color: AppColors.appPrimaryColor),
        ).marginSymmetric(vertical: 6.h),
      ],
    );
  }

  Widget _buildExpiryInfo() {
    return RichText(
      text: TextSpan(
        text: "this_code_will_expire_in".tr,
        style: AppFontsStyle.forgotFonts,
        children: [
          TextSpan(
            text: "five_minutes".tr,
            style: TextStyle(color: AppColors.appPrimaryColor, fontWeight: FontWeight.w400, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        CustomButton(
          // loading: controllerVerifyOtp.isLoading.value,
          // onTap: () => controllerVerifyOtp.verifyOtp(isSignUp, email),
          text: "verify_code".tr,  // Use translation key
          textColor: Colors.white,
          buttonColor: Colors.black,
        ),
        CustomButton(
          // loading: controllerVerifyOtp.resendLoading.value,
          // onTap: () => controllerVerifyOtp.resendOTP(email),
          text: "resend_code".tr,  // Use translation key
          textColor: Colors.white,
          buttonColor: AppColors.appGreyColor,
        ).marginOnly(top: 10.sp),
      ],
    );
  }
}
