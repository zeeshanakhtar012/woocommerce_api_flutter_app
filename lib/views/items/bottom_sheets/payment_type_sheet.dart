import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';

class PaymentTypeSheet {
  static void show(BuildContext context) {
    String? _selectedOption;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.23.h,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ).marginOnly(bottom: 20),
                Row(
                  children: [
                    Text(
                      "Select Payment Type",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, size: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text("Express Delivery"),
                  leading: Radio<String>(
                    value: "on_cash",
                    activeColor: AppColors.appPrimaryColor,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      if (value != null) {
                        _selectedOption = value;
                        Navigator.pop(context);
                      }
                    },
                  ),
                  onTap: () {
                    _selectedOption = "on_cash";
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Online"),
                  leading: Radio<String>(
                    value: "credit_card",
                    activeColor: AppColors.appPrimaryColor,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      if (value != null) {
                        _selectedOption = value;
                        Navigator.pop(context);
                      }
                    },
                  ),
                  onTap: () {
                    _selectedOption = "credit_card";
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
