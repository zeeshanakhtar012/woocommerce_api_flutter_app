import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../widgets/skeleton/custom_skeleton.dart/image_skeleton.dart';

class ItemHomeCategory extends StatelessWidget {
  final String dressName;
  final VoidCallback? onTap;
  final String dressItems;
  final String dressImageUrl;

  ItemHomeCategory({
    required this.dressName,
    this.onTap,
    required this.dressItems,
    required this.dressImageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // print("dressImageUrl ${dressImageUrl}");
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 92.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70.h,
              width: 92.w,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors
                    .white, // Ensure the background matches the container color
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [AppColors.myCustomBoxShadow],
                // image: DecorationImage(
                //     image: NetworkImage(dressImageUrl), fit: BoxFit.contain),
              ),
              child: 
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: dressImageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => ImageSkeleton(
                    height: 70.h,
                    width: 92.w,
                  ),
                ),
              ),
            ),
            Text(
              dressName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.sp,
                color: Color(0xff4C6042),
                fontWeight: FontWeight.w600,
              ),
            ).marginOnly(top: 5.sp),
            Text(
              "${dressItems} items",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w300,
                color: Color(0xff4C6042),
              ),
            ),
          ],
        ),
      ),
    ).marginOnly(right: 12.w);
  }
}
