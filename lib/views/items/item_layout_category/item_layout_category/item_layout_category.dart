import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../widgets/skeleton/custom_skeleton.dart/image_skeleton.dart';

class ItemLayoutCategory extends StatelessWidget {
  String dressName;
  String dressImageUrl;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 3.h,
        ),
        height: 99.h,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [AppColors.myCustomBoxShadow],
        ),
        child: Row(
          children: [
            Container(
              height: 77.29.h,
              width: 77.29.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [AppColors.myCustomBoxShadow],
              ),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: dressImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ImageSkeleton(
                    height: 60.h,
                    width: 6.w,
                  ),
                ),
              ),
            ).marginOnly(
              left: 10.w,
            ),
            Text(
              "$dressName",
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xff4C6042),
                  fontWeight: FontWeight.w600),
            ).marginSymmetric(
              horizontal: 15.w,
            ),
          ],
        ),
      ),
    );
  }

  ItemLayoutCategory({
    required this.dressName,
    required this.dressImageUrl,
    required this.onTap,
  });
}
