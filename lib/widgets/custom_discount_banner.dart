import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DiscountBanner extends StatelessWidget {
  String discountPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 50.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/discount.png'),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth, 
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, 
        children: [
          SizedBox(height: 6,),
          Text(
            'Disc',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${discountPrice.split('.')[0]}%",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  DiscountBanner({
    required this.discountPrice,
  });
}
