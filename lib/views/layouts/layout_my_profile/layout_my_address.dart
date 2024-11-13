import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_authentication.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_field.dart';

class LayoutAddress extends StatelessWidget {
  LayoutAddress({super.key});

  final ControllerAuthentication controller = Get.put(ControllerAuthentication());

  Future<String?> getUserId() async {
    final int? userId = await controller.getUserId();
    return userId?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserId(),
      builder: (context, snapshot) {
        // Show loading while fetching user ID
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if user ID is null
        final userId = snapshot.data;

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  radius: 10.r,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ).marginSymmetric(horizontal: 10.sp, vertical: 10.sp),
              ),
              title: Text("MY ADDRESS", style: AppFontsStyle.profileAppBar),
              centerTitle: true,
            ),
            body: userId == null
                ? Center(
              child: Text(
                "Please Contact with ZRJ Fashion Team!",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            )
                : SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Add an address", style: AppFontsStyle.profileTitle),
                  ),
                  CustomTextField(
                      controller: controller.firstName.value,
                      hintText: 'First Name'),
                  CustomTextField(
                      controller: controller.lastName.value,
                      hintText: 'Last Name'),
                  CustomTextField(
                      controller: controller.firstName.value,
                      hintText: 'Enter phone number'),
                  CustomTextField(hintText: 'Address'),
                  CustomTextField(hintText: 'Further information (Optional)'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextField(
                      width: 150.w,
                      hintText: 'Region',
                    ),
                  ),
                  CustomButton(
                    loading: controller.isLoading.value,
                    onTap: () async {
                     await controller.updateUserDetails("${userId}");
                    },
                    text: "ADD ADDRESS",
                    textColor: Colors.white,
                    buttonColor: AppColors.buttonColor,
                  ).marginOnly(top: 20.sp),
                ],
              ).marginSymmetric(vertical: 10.sp, horizontal: 15.sp),
            ),
          ),
        );
      },
    );
  }
}
