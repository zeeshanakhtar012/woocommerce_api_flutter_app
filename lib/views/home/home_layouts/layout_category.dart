import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';

class LayoutCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text(
          "Categories",
          style: AppFontsStyle.profileAppBar.copyWith(fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomImageCard(imagePath: 'assets/images/Product_1.png', title: 'Summer Specials', onTap: () {  },),
          CustomImageCard(imagePath: 'assets/images/Product_1.png', title: 'Spring Collection', onTap: () {  },),
          CustomImageCard(imagePath: 'assets/images/Product_1.png', title: 'Winter Collection', onTap: () {  },),
          CustomImageCard(imagePath: 'assets/images/Product_1.png', title: 'Wedding Collection', onTap: () {  },),
        ],
      ),
    );
  }
}

class CustomImageCard extends StatelessWidget {
  const CustomImageCard({
    super.key, required this.imagePath, required this.title, required this.onTap,
  });
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Get.height/7,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(imagePath)),
        ),
        child: Center(
          child: Text(title,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
        ),
      ),
    );
  }
}

