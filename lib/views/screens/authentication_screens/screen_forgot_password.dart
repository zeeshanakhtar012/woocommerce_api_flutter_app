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
                isSignUp ? "Verify your email" : "Forgot password",
                style: AppFontsStyle.logInTitle,
              ).marginOnly(bottom: 11.h),
              Text(
                isSignUp
                    ? "Please check your email for the OTP"
                    : "Don’t worry, we’ll help you reset it \nin no time.",
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
          child:  PinPut(
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
      ].marginSymmetric(vertical: 30.h, horizontal: 32.w),
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
        Text("Code was sent to your email", style: AppFontsStyle.forgotFonts),
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
        text: "This code will expire in",
        style: AppFontsStyle.forgotFonts,
        children: [
          TextSpan(
            text: " 5 minutes",
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
            text: "VERIFY CODE",
            textColor: Colors.white,
            buttonColor: Colors.black,
          ),
        
        CustomButton(
          // loading: controllerVerifyOtp.resendLoading.value,
          // onTap: () => controllerVerifyOtp.resendOTP(email),
          text: "RESEND CODE",
          textColor: Colors.white,
          buttonColor: AppColors.appGreyColor,
        ).marginOnly(top: 10.sp),
      ],
    );
  }
}

extension on List<Widget> {
  marginSymmetric({required double vertical, required double horizontal}) {}
}
