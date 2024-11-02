import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart'; 
import '../../../constants/fonts.dart';
import '../../../utils/form_valid.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/my_costom_textt_field.dart';
import '../screen_test.dart';

class ScreenResetPassword extends StatelessWidget {
  final String email;
  ScreenResetPassword({super.key, required this.email});
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 226.h,
              width: Get.width,
              padding: EdgeInsets.only(right: 22.w, bottom: 22.h, top: 8.h),
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
                      // bottom: 120.h,
                      child: AnimatedSvg(
                        svgAssetPath: "assets/icons/spiral.svg",
                        color: Colors.white.withOpacity(0.2),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Get.back();
                        },
                        icon: SvgPicture.asset("assets/icons/back-button.svg"),
                      ).marginOnly(bottom: 48.h),
                      Text(
                        "Set new password",
                        style: AppFontsStyle.logInTitle,
                      ).marginOnly(bottom: 11.h),
                      Text(
                        "Create a strong password to secure \nyour account",
                        textAlign: TextAlign.start,
                        style: AppFontsStyle.logInSubtitle.copyWith(
                            color: Colors.white,
                            fontSize: 12.sp,
                            height: 2.5,
                            fontWeight: FontWeight.w300),
                      ).marginOnly(bottom: 0.h)
                    ],
                  ).marginSymmetric(
                    horizontal: 32.w,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // Obx(() {
                //   return MyInputField(
                //     controller: updatePassword.oldPassword.value,
                //     isPasswordField: true,
                //     hint: "Enter old password",
                //   );
                // }),
                
                   MyCostomTexttField(
                    
                    isPasswordField: true,
                    hint: "Enter new password",
                    validator: FormValidator.validatePassword,
                  ),
                 
                    MyInputField(

                    isPasswordField: true,
                    hint: "Confirm new password",
                    
                  ),
                 
              ],
            ).marginSymmetric(
              vertical: 30.h,
              horizontal: 15.w,
            ),
            Spacer(),
            CustomButton(
              
              onTap: () async {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // String? token = prefs.getString('access_token');
                // print('Retrieved Token: $token');
                //check
            
                // if (!isPasswordValid(updatePassword.newPassword.value.text)) {
                //   showQuickAlert('Please enter a valid password');
                // } else if (!isPasswordValid(
                //     updatePassword.confirmPassword.value.text)) {
                //   showQuickAlert('Please confirm your password');
                // } else if (!isConfirmPasswordValid(
                //     updatePassword.newPassword.value.text,
                //     updatePassword.confirmPassword.value.text)) {
                //   showQuickAlert('Password does not match');
                // } else {
                //   debugPrint("Password validation done");
                //   updatePassword.resetPassword(email);
                // }
                 
              },
              
              text: "SAVE PASSWORD",
              textColor: Colors.white,
              buttonColor: Colors.black,
            ).marginOnly(
              left: 30.sp,
              right: 30.sp,
              bottom: 60.sp,
            ),
          ],
        ),
      ),
    );
  }
}
