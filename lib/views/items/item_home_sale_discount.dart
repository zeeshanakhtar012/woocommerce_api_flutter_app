import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 
import 'package:get/get.dart';
import 'package:zrj/model/product.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_add_cart_container.dart';
import '../../widgets/skeleton/custom_skeleton.dart/image_skeleton.dart';
import '../../widgets/custom_discount_banner.dart';

class ItemSaleDiscount extends StatelessWidget {
  final Product product;

  ItemSaleDiscount({required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigation logic can be added here
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w, bottom: 10.h, left: 3.w),
        height: 173.h,
        width: 124.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [AppColors.myCustomBoxShadow],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: product.images[0].src,
                          fit: BoxFit.cover,
                          height: 139.h,
                          width: 86.w,
                          placeholder: (context, url) => ImageSkeleton(
                            height: 100.h,
                            width: 86.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    product.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xff4C6042),
                      fontWeight: FontWeight.w500,
                    ),
                  ).marginSymmetric(vertical: 4.h),
                  Row(
                    children: [
                      Text(
                        "\$ 44",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff4C6042),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          "\$ 0}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 8.sp,
                            color: Color(0xff4C6042),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Spacer(),
                      CustomContainer(productId: '', isInWishlist: true, onToggleWishlist: (String ) {  },
                         
                      ),
                    ],
                  ).marginOnly(top: 0.r, left: 10.w, right: 10.w, bottom: 10.h),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: DiscountBanner(
                discountPrice:  "0",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
