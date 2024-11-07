import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_authentication.dart';
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
  ControllerAuthentication controller = Get.put(ControllerAuthentication());

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
      // height: 226.h,
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
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'signup_signin_text'.tr, // Use translation key here
                    style: AppFontsStyle.loginOption,
                  ),
                ),
              ).marginOnly(bottom: 48.h),
              Text(
                'signup_title'.tr, // Use translation key here
                style: AppFontsStyle.logInTitle,
              ).marginOnly(bottom: 11.h),
              Text(
                'signup_subtitle'.tr, // Use translation key here
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
          controller: controller.firstName.value,
          hint: 'signup_first_name_hint'.tr, // Use translation key here
          validator: FormValidator.validateName,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          controller: controller.lastName.value,
          hint: 'signup_last_name_hint'.tr, // Use translation key here
          validator: FormValidator.validateName,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          controller: controller.userName.value,
          hint: 'signup_username_hint'.tr, // Use translation key here
          validator: FormValidator.validateUserName,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          controller: controller.email.value,
          hint: 'signup_email_hint'.tr, // Use translation key here
          validator: FormValidator.validateEmail,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          controller: controller.country.value,
          hint: 'Country',
        ).marginOnly(bottom: 10.h),
        MyInputField(
          controller: controller.address.value,
          hint: 'Address', // Use translation key here
          validator: FormValidator.validateAddress,
        ).marginOnly(bottom: 10.h),
        MyInputField(
          controller: controller.phoneNumber.value,
          keyboardType: TextInputType.phone,
          hint: 'Phone',
        ).marginOnly(bottom: 10.h),
      ],
    ).marginSymmetric(vertical: 30.h, horizontal: 32.w);
  }

  Widget _buildSignUpButton() {
    return CustomButton(
      loading: controller.isLoading.value,
      onTap: () async {
        if (_formKey.currentState?.validate() ?? false) {
          controller.signupUser();
        } else {
          _showQuickAlert('signup_alert'.tr); // Use translation key here
        }
      },
      text: 'signup_button_text'.tr, // Use translation key here
      textColor: Colors.white,
      buttonColor: AppColors.buttonColor,
    ).marginOnly(left: 32.w, right: 32.w, top: 20.sp, bottom: 34.h);
  }
}
