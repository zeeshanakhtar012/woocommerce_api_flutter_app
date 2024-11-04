import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/fonts.dart';

class ScreenProductSubcategory extends StatelessWidget {
  final int categoryID;
  final String categoryName;

  ScreenProductSubcategory({
    required this.categoryID,
    required this.categoryName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: InkWell(
          onTap: () => Get.back(),
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: Colors.red,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ).marginSymmetric(horizontal: 10.sp, vertical: 10.sp),
        ),
        title: Text(
          categoryName,
          style: AppFontsStyle.profileAppBar.copyWith(fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/no_result.png',
                color: Colors.black,
                width: 50,
              ),
              Text(
                'No subcategory items found.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ).marginSymmetric(vertical: 10.h),
              Text(
                "Please check other categories",
                textAlign: TextAlign.center,
              ).marginSymmetric(horizontal: 50.w),
            ],
          ),
        ),
      ),
    );
  }
}
