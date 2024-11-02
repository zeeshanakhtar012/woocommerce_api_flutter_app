import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zrj/model/product.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_add_cart_container.dart'; 
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemWishListProduct extends StatelessWidget {
  final Product product;
  bool isExpanded = false;

  ItemWishListProduct({required this.product});

  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
            
              onPressed: doNothing,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.only(left: 29.w, right: 21.w, top: 14.h, bottom: 8.h),
                width: Get.width,
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
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 114.h,
                                width: 114.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [AppColors.myCustomBoxShadow],
                                  image: DecorationImage(
                                    image: NetworkImage(product.images!.first.imagePath!),
                                    fit: BoxFit.cover,
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
                                            product.name!,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Color(0xff4C6042),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        CustomContainer(
                                          productId: '', isInWishlist: true, onToggleWishlist: (String ) {  }, 
                                        ).marginOnly(right: 5.w),
                                         isExpanded
                                              ? SizedBox()
                                              : InkWell(
                                                  child: SvgPicture.asset("assets/icons/delete.svg"),
                                                  onTap: () {
                                                    isExpanded = !isExpanded;
                                                  },
                                                ),
                                        
                                      ],
                                    ).marginSymmetric(vertical: 3.5.h),
                                    Text(
                                      "Color: color",
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0xff4C6042),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ).marginSymmetric(vertical: 3.5.h),
                                    Text(
                                      "Size: size",
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
                                        border: Border.all(color: Color(0xff4C6042), width: 0.2),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Icon(Icons.remove, size: 18.sp),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.appPrimaryColor,
                                            thickness: 0.2,
                                          ),
                                          Text(
                                            "\$quantity",
                                            style: TextStyle(fontSize: 12.sp),
                                          ),
                                          VerticalDivider(
                                            color: AppColors.appPrimaryColor,
                                            thickness: 0.2,
                                          ),
                                          InkWell(
                                            onTap: () {},
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
                        ),
                      ],
                    ),
                    Divider(color: AppColors.appGreyColor, thickness: 0.2).marginOnly(top: 8.h, bottom: 7.h),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "Sub Total: ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xff4C6042),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\$ ",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFFFF0000),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.h),
                        height: 35.h,
                        width: 184.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withOpacity(0.5), width: 1),
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
              isExpanded
                  ? Container(
                      width: 34.w,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            
          ],
        ),
      ),
    ).marginSymmetric(vertical: 5.h);
  }
}
