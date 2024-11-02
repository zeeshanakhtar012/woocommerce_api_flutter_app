import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/fonts.dart';
import '../../../utils/form_valid.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/my_costom_textt_field.dart';
import '../../home/home_screen.dart';
import '../screen_test.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});

  final _formKey = GlobalKey<FormState>();

  void _showQuickAlert(String description, {String title = "Error"}) {
    Get.snackbar(
      title,
      description,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 20,
      margin: EdgeInsets.symmetric(vertical: 35.h, horizontal: 15.w),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeIn,
      icon: const Icon(Icons.error, color: Colors.white),
      shouldIconPulse: true,
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 10.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildHeader(),
                _buildFormFields(),
                _buildSignUpButton(),
              ],
            ),
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
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "SIGN IN",
                    style: AppFontsStyle.loginOption,
                  ),
                ),
              ).marginOnly(bottom: 48.h),
              Text(
                "Sign Up",
                style: AppFontsStyle.logInTitle,
              ).marginOnly(bottom: 11.h),
              Text(
                "Join us today and enjoy a personalized shopping \nexperience.",
                textAlign: TextAlign.start,
                style: AppFontsStyle.logInSubtitle.copyWith(
                    color: Colors.white,
                    fontSize: 12.sp,
                    height: 2.5,
                    fontWeight: FontWeight.w300),
              ).marginOnly(bottom: 10.h),
            ],
          ).marginSymmetric(horizontal: 32.w),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        MyCostomTexttField(
          hint: "Your First Name",
          validator: FormValidator.validateName,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          hint: "Your Last Name",
          validator: FormValidator.validateName,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          hint: "Your User Name",
          validator: FormValidator.validateUserName,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          hint: "Your Email",
          validator: FormValidator.validateEmail,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          isPasswordField: true,
          hint: "Your Password",
          validator: FormValidator.validatePassword,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          isPasswordField: true,
          hint: "Confirm Password",
          validator: (value) {
            // Add your validation logic here
          },
        ).marginOnly(bottom: 30.h),
      ],
    ).marginSymmetric(vertical: 30.h, horizontal: 32.w);
  }

  Widget _buildSignUpButton() {
    return CustomButton(
      onTap: () async {
        if (_formKey.currentState?.validate() ?? false) {
          Get.to(HomeScreen());
        } else {
          _showQuickAlert("Please fill out all fields correctly.");
        }
      },
      text: "SIGN UP",
      textColor: Colors.white,
      buttonColor: Colors.black,
    ).marginOnly(left: 32.w, right: 32.w, top: 20.sp, bottom: 34.h);
  }
}
