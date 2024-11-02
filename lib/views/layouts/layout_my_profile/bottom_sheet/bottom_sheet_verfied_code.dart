import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_button.dart';

class OtpVerifiedSuccessful {

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
              // height: 200.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: (){
                      }, icon: Icon(Icons.close, color: Colors.transparent,)),
                      Container(
                        height: 3.h,
                        width: 71.w,
                        decoration: BoxDecoration(
                            color: Color(0xff4C6042),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(
                        // size: 20.h,
                        Icons.close, color: Colors.white,)),
                    ],
                  ).marginOnly(top: 6.sp),
                  CircleAvatar(
                    radius: 45.r,
                    backgroundColor: Color(0xff4C6042),
                    child: Icon(Icons.done, color: Colors.white,),
                  ),
                  Text("SUCCESS", style: TextStyle(
                    fontSize: 20.sp,
                    color: Color(0xff4C6042),
                    fontWeight: FontWeight.w500,
                  ),),
                  Text("Thank you your debit card has been added. \nYou can easily shop with Fee now!", style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff4C6042),
                    fontWeight: FontWeight.w500,
                  ),).marginOnly(
                    top: 35.sp,
                  ),
                  Spacer(),
                  CustomButton(
                    onTap: () {
                      // OtpVerifiedSuccessful.show(context);
                    },
                    text: "CONTINUE SHOPPING",
                    textColor: Colors.white,
                    buttonColor: Colors.black,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
