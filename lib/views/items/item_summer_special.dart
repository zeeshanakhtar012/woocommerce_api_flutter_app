import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/model/product.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_add_cart_container.dart';
import '../screens/screen_products_details copy.dart';

class DressItemCard extends StatelessWidget {
  Product product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ScreenProductDetails(product: product,
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [AppColors.myCustomBoxShadow],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: FadeInImage(
                        image:  NetworkImage(product.images!.first.src!),
                        placeholder: AssetImage(
                            'assets/images/image_dress.png'),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Center(child: Text("No Image"));
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8.h,
                    right: 8.w,
                    child: CustomContainer(
                      productId: '',
                      isInWishlist: false,
                      onToggleWishlist: (String) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.name!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.appPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Text(
                "\$4",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Color(0xff4C6042),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DressItemCard({
    required this.product,
  });
}
