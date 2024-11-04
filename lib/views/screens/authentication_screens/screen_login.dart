import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';
import 'package:zrj/views/screens/authentication_screens/screen_email.dart';
import 'package:zrj/views/screens/authentication_screens/screen_signup.dart';
import '../../../constants/fonts.dart';
import '../../../utils/form_valid.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/my_costom_textt_field.dart';
import '../../home/home_screen.dart';
import '../screen_test.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  final _formKey = GlobalKey<FormState>();
  final passwordError = "".obs;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildHeader(),
              _buildLoginForm(),
              Spacer(),
              _buildSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 226.h,
      width: Get.width,
      padding: EdgeInsets.symmetric(vertical: 22.h),
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
            child: AnimatedSvg(
              svgAssetPath: "assets/icons/spiral.svg",
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Get.to(ScreenSignUp()),
                  child: Text(
                    'login_sign_up'.tr, // Use translation key here
                    style: AppFontsStyle.loginOption,
                  ),
                ),
              ).marginOnly(bottom: 48.h),
              Text('login_title'.tr, style: AppFontsStyle.logInTitle) // Use translation key
                  .marginOnly(bottom: 11.h),
              Text(
                'login_subtitle'.tr, // Use translation key
                textAlign: TextAlign.start,
                style: AppFontsStyle.logInSubtitle.copyWith(
                  color: Colors.white,
                  fontSize: 12.sp,
                  height: 2.5,
                  fontWeight: FontWeight.w300,
                ),
              ).marginOnly(bottom: 10.h),
            ],
          ).marginSymmetric(horizontal: 32.w),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        MyCostomTexttField(
          hint: 'login_email_hint'.tr, // Use translation key
          validator: FormValidator.validateEmail,
        ).marginOnly(bottom: 10.h),
        MyCostomTexttField(
          hint: 'login_password_hint'.tr, // Use translation key
          isPasswordField: true,
          validator: FormValidator.validatePassword,
        ),
        Text(
          passwordError.value,
          style: TextStyle(color: Colors.red),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => Get.to(ScreenEmail()),
            child: Text(
              'login_forgot_password'.tr, // Use translation key
              style: TextStyle(color: Color(0xFFE41A4A), fontSize: 12.sp),
            ),
          ),
        ).marginSymmetric(vertical: 6.sp),
      ],
    ).marginSymmetric(vertical: 30.h, horizontal: 32.w);
  }

  Widget _buildSignInButton() {
    return CustomButton(
      onTap: () async {
        // if (_formKey.currentState?.validate() ?? false) {
        //   Get.to(HomeScreen());
        // }
        Get.to(HomeScreen());
      },
      text: 'login_sign_in'.tr, // Use translation key
      textColor: Colors.white,
      buttonColor: AppColors.buttonColor,
      loading: false, // Update with actual loading state
    ).marginSymmetric(horizontal: 32.w, vertical: 70.h);
  }
}
