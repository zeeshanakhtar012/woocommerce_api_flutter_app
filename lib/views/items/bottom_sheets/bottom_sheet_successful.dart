import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../widgets/custom_button.dart';
import '../../home/home_screen.dart';

class PaymentSuccessfulBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 400.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 3.h,
                    width: 45.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 40.r,
                backgroundColor: Color(0xff4C6042),
                child: Icon(
                  size: 30.sp,
                  Icons.done,
                  color: Colors.white,
                ),
              ).marginOnly(top: 20.sp),
              Text(
                "Success",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ).marginOnly(top: 10.sp),
              Spacer(),
              Text(
                "Thank you for purchasing. Your order will be shipped in 2 - 4 working days.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp),
              ).marginOnly(top: 10.sp),
              Spacer(),
              CustomButton(
                onTap: () => Get.offAll(() => HomeScreen()),
                text: "CONTINUE SHOPPING",
                textColor: Colors.white,
                buttonColor: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }
}
