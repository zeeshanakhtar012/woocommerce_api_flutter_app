import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zrj/model/product.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_package/cusotm_images_slider_deatils.dart';

class ScreenProductDetails extends StatelessWidget {
  final Product product;

  ScreenProductDetails({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: AppFontsStyle.buildBackButton(context),
        centerTitle: true,
        title: Text("${product.name}", style: AppFontsStyle.profileAppBar),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       // Get.to(() => ScreenFavouriteProduct());
        //     },
        //     child: Container(
        //       height: 37.h,
        //       width: 37.w,
        //       padding: EdgeInsets.all(8.sp),
        //       margin: EdgeInsets.only(right: 10.w),
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Color(0xff4C6042),
        //       ),
        //       child: SvgPicture.asset("assets/icons/fav_icon_fill.svg"),
        //     ),
        //   ),
        // ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SlidingImageContainer(product: product),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF6B6B6B).withOpacity(.25),
                    blurRadius: 5,
                    spreadRadius: 0,
                    offset: Offset(1, 0),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 5.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffA7A7A7),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name ?? "",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff4C6042),
                          ),
                        ),
                      ),
                      Text(
                        '\$0',
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff4C6042),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.sp,
                    child: Row(
                      children: [
                        Text(
                          'Size :',
                          style: TextStyle(
                            color: Color(0xff4C6042),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        // Size selection logic can be added here
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.sp,
                    child: Row(
                      children: [
                        Text(
                          'Choose Color',
                          style: TextStyle(
                            color: Color(0xff4C6042),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        // Color selection logic can be added here
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Quality :',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff4C6042),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          // Quantity selection logic can be added here
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Color(0xff4C6042),
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "Elegant and modest, this abaya features a flowing design with intricate embroidery. Crafted from high-quality fabric, it offers both comfort and style, perfect for any occasion.",
                    style: TextStyle(
                      color: Color(0xff4C6042),
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                      height: 1.8,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: CustomButton(
                      height: 62.h,
                      onTap: () {
                        // Add to cart logic can be added here
                      },
                      text: "ADD TO CART",
                      textColor: Colors.white,
                      buttonColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
