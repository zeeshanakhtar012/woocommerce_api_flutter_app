import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';

import '../../../constants/fonts.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_button_border_color.dart';
import '../../../widgets/custom_field.dart';

class LayoutAddress extends StatelessWidget {
  LayoutAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: CircleAvatar(
              radius: 10.r,
              backgroundColor: Colors.red,
              child: Icon(Icons.arrow_back, color: Colors.white,),
            ).marginSymmetric(
              horizontal: 10.sp,
              vertical: 10.sp,
            ),
          ),
          title: Text("MY ADDRESS", style: AppFontsStyle.profileAppBar,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Add an address", style: AppFontsStyle.profileTitle,),
              ),
              CustomTextField(
                hintText: 'First Name',
              ),
              CustomTextField(
                hintText: 'Last Name',
              ),
              CustomTextField(
                hintText: 'Enter phone number',
              ),
              CustomTextField(
                hintText: 'Address',
              ),
              CustomTextField(
                hintText:'Further information (Optional)',
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomTextField(
                  width: 150.w,
                  hintText:  'Region',
                ),
              ),

              CustomButton(
                // loading: updateProfile.isLoading.value,
                onTap: ()  {
                  // await updateProfile.updateProfile();
                },
                text: "ADD ADDRESS",
                textColor: Colors.white,
                buttonColor: AppColors.buttonColor,
              ).marginOnly(
                top: 20.sp,
              )
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
