import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class CustomToggleSwitch extends StatelessWidget {
  final List<String> labels;
  final Function(int) onToggle;
  final int selectedIndex;

  CustomToggleSwitch({
    required this.labels,
    required this.onToggle,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*.57,
      constraints: BoxConstraints(
        minHeight: 45.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(labels.length, (index) {
          bool isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => onToggle(index),
            child: Container(
              constraints: BoxConstraints(
                minHeight: 40.h,
                minWidth: 80.w,
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                boxShadow:[
                  AppColors.boxShadow
                ],
                color: isSelected ? Colors.white : Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
