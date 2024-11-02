import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../widgets/custom_button_border_color.dart';

class ItemProfilePurchases extends StatelessWidget {
  String purchaseNo;
  String purchaseDate;
  String purchaseType;
  String purchasePrice;
  String? purchaseButtonText;
  VoidCallback? onTap;
  ItemProfilePurchases({
    required this.purchaseNo,
    required this.purchaseDate,
    required this.purchaseType,
    required this.purchasePrice,
    this.purchaseButtonText,
    this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 29.w,vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
        color: Colors.white,
        boxShadow: [
          AppColors.myCustomBoxShadow
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${purchaseNo}", style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w500
              ),).marginOnly(top: 5.h),
              Text("${purchaseDate}", style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w300
              ),).marginSymmetric(vertical: 5.h),
              Text("${purchaseType}", style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.appPrimaryColor,
                fontWeight: FontWeight.w300
              ),).marginOnly(bottom: 5.h),

              Text("${purchasePrice.split('.')[0]}", style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.appPrimaryColor,
              ),),
            ],
          ),
          CustomButtonBorder(
            onTap: onTap,
            buttonColor: Colors.black,
            textColor: Colors.white,
            isRound: false,
            fontSize: 14.sp,

            width: 90.w,
              height: 37.h,
              text: "See details",
          )
        ],
      ),
    );
  }
}
