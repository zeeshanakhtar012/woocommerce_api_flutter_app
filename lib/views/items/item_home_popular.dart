import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_add_cart_container.dart';
import '../../widgets/skeleton/custom_skeleton.dart/image_skeleton.dart';

class ItemHomePopular extends StatelessWidget {
  final String productName;
  final String imageUrl;
  final double price;

  ItemHomePopular({
    required this.productName,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigation logic can be added here
      },
      child: SizedBox(
        height: 132.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 102.h,
              width: Get.width,
              padding: EdgeInsets.only(left: 120.w, right: 15.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [AppColors.myCustomBoxShadow],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xff4C6042),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      CustomContainer(productId: '', isInWishlist: true, onToggleWishlist: (String ) {  }, 
                      ),
                    ],
                  ),
                  Text(
                    "\$$price",
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Color(0xff4C6042),
                        fontWeight: FontWeight.w700),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 24.h,
                      width: 51.w,
                      padding: EdgeInsets.all(5.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Color(0xff4C6042),
                      ),
                      child: SvgPicture.asset("assets/icons/icon_store.svg"),
                    ),
                  ),
                ],
              ).marginSymmetric(vertical: 15.h),
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                height: 132.h,
                width: 105.6.w,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [AppColors.myCustomBoxShadow],
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => ImageSkeleton(
                      height: 100.h,
                      width: 105.6,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ).marginSymmetric(horizontal: 30.w),
    );
  }
}
