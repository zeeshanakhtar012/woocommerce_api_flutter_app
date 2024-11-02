import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
        color: Colors.black,
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
                    "SIGN UP",
                    style: AppFontsStyle.loginOption,
                  ),
                ),
              ).marginOnly(bottom: 48.h),
              Text("Sign in", style: AppFontsStyle.logInTitle)
                  .marginOnly(bottom: 11.h),
              Text(
                "Access your account to start shopping and\nmanage your orders.",
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
          hint: "Email",
          validator: FormValidator.validateEmail,
        ).marginOnly(bottom: 10.h),
        MyCostomTexttField(
          hint: "Password",
          isPasswordField: true,
          validator: FormValidator.validatePassword,
          // onChanged: (value) {
          //   // Add your password change logic here
          //   // e.g., if invalid, update passwordError.value
          //   if (value.isEmpty) {
          //     passwordError.value = "Password cannot be empty";
          //   } else {
          //     passwordError.value = ""; // Clear the error
          //   }
          // },
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
              "Forgot Password?",
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
      text: "SIGN IN",
      textColor: Colors.white,
      buttonColor: Colors.black,
      loading: false, // Update with actual loading state
    ).marginSymmetric(horizontal: 32.w, vertical: 70.h);
  }
}
