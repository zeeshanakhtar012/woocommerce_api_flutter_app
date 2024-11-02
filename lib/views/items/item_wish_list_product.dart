import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_add_cart_container.dart';
import '../../widgets/skeleton/custom_skeleton.dart/image_skeleton.dart';
import '../layouts/layout_my_profile/layout_purchase_receipt.dart';

class ItemWishListProduct extends StatefulWidget {
  final Product product;
  final int index;

  ItemWishListProduct({
    required this.product,
    required this.index,
  });

  @override
  _ItemWishListProductState createState() => _ItemWishListProductState();
}

class _ItemWishListProductState extends State<ItemWishListProduct> {
  bool isExpanded = false;

  void _increaseQuantity() {
    // Your logic to increase quantity, you might need to manage the state here
  }

  void _decreaseQuantity() {
    // Your logic to decrease quantity, you might need to manage the state here
  }

  void addToBasket(int productId) {
    // Your logic to add the product to the cart
  }

  double getDiscountedPrice(Product product) {
    String price = "0";
    int discountStatus = 0;
    double discount = 0.0;

    // if (discountStatus != 0) {
    //   discount = (product.discountPercentage != null)
    //       ? (price * (double.parse(product.discountPercentage!) / 100))
    //       : 0.0;
    // }

    // return price - discount;
    return discount;
  }

  @override
  Widget build(BuildContext context) {
    double priceCalculate = getDiscountedPrice(widget.product);

    return IntrinsicHeight(
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < -5) {
            setState(() {
              isExpanded = true;
            });
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            setState(() {
              isExpanded = false;
            });
          }
        },
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 14.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  color: Colors.white,
                  boxShadow: [AppColors.myCustomBoxShadow],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 114.h,
                          width: 114.w,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [AppColors.myCustomBoxShadow],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl: widget.product.images!.first.imagePath!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => ImageSkeleton(
                                height: 90.h,
                                width: 112.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.product.name!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xff4C6042),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  CustomContainer(
                                    productId: '',
                                    isInWishlist: true,
                                    onToggleWishlist: (String) {},
                                  ).marginOnly(right: 5.w),
                                  if (!isExpanded)
                                    InkWell(
                                      child: SvgPicture.asset(
                                          "assets/icons/delete.svg"),
                                      onTap: () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                    ),
                                ],
                              ).marginSymmetric(vertical: 3.5.h),
                              Text(
                                "Color: colors",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Color(0xff4C6042),
                                  fontWeight: FontWeight.w400,
                                ),
                              ).marginSymmetric(vertical: 3.5.h),
                              Text(
                                "Size: sizes",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Color(0xff4C6042),
                                  fontWeight: FontWeight.w400,
                                ),
                              ).marginSymmetric(vertical: 3.5.h),
                              Text(
                                "\$ price",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xff4C6042),
                                  fontWeight: FontWeight.w400,
                                ),
                              ).marginSymmetric(vertical: 3.5.h),
                              Container(
                                height: 23.h,
                                width: 93.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff4C6042), width: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: _decreaseQuantity,
                                      child: Icon(Icons.remove, size: 18.sp),
                                    ),
                                    VerticalDivider(
                                        color: AppColors.appPrimaryColor,
                                        thickness: 0.2),
                                    Text(
                                      "1", // Replace with quantity variable as needed
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    VerticalDivider(
                                        color: AppColors.appPrimaryColor,
                                        thickness: 0.2),
                                    InkWell(
                                      onTap: _increaseQuantity,
                                      child: Icon(Icons.add, size: 18.sp),
                                    ),
                                  ],
                                ),
                              ).marginSymmetric(vertical: 3.5.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.appGreyColor, thickness: 0.2)
                        .marginOnly(top: 8.h, bottom: 7.h),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "SubTotal:",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xff4C6042),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\$${priceCalculate.toStringAsFixed(0)}", // Placeholder calculation
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFFFF0000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // addToBasket(widget.product.id!);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        height: 35.h,
                        width: 184.w,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.5), width: 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Add to basket",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF989898),
                            ),
                          ),
                        ),
                      ).marginSymmetric(vertical: 6.h),
                    ),
                  ],
                ),
              ),
            ),
            if (isExpanded)
              Flexible(
                fit: FlexFit.loose,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: isExpanded ? 50 : 0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset("assets/icons/delete.svg",
                            color: Colors.white),
                        onPressed: () async {
                          // Your logic to toggle the wishlist status
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ).marginSymmetric(vertical: 5.h),
      ),
    );
  }
}
