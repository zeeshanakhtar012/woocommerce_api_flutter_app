import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_package/pin_put.dart';

class PaymentBottomSheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.6),
                    offset: Offset(0, -5),
                    blurRadius: 10.0,
                    spreadRadius: 0.6,
                  )
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
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
                  Text(
                    "Enter the My Pay pin",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ).marginOnly(top: 30.sp),
                  PinPut(
                    textStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff4C6042),
                    ),
                    followingFieldDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 10,
                          spreadRadius: 0.6,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    eachFieldHeight: 63.h,
                    eachFieldWidth: 63.w,
                    submittedFieldDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 10,
                          spreadRadius: 0.6,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    selectedFieldDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.15),
                          blurRadius: 10,
                          spreadRadius: 0.6,
                          offset: Offset(0, -4),
                        ),
                      ],
                    ),
                    cursorColor: Colors.black,
                    fieldsCount: 4,
                  ).marginOnly(top: 30.sp),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Pin?",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    text: "Buy",
                    textColor: Colors.white,
                    buttonColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
