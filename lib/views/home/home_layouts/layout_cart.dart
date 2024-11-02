import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_listview_builder.dart';
import '../../../widgets/skeleton/custom_skeleton.dart/cart_skeleton.dart';
import '../../screens/screen_test.dart';
class LayoutCart extends StatefulWidget {
  final bool isHome;

  LayoutCart({required this.isHome});

  @override
  _LayoutCartState createState() => _LayoutCartState();
}

class _LayoutCartState extends State<LayoutCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: Text(
          "MY Cart",
          style: AppFontsStyle.profileAppBar,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Clear Cart",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              Positioned(
                top: 0.h,
                left: 132.w,
                right: 91.w,
                child: AnimatedSvg(
                  svgAssetPath: "assets/icons/home_line.svg",
                  color: Colors.black.withOpacity(.2),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: CustomListviewBuilder(
                  scrollDirection: CustomDirection.vertical,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return CartSkeleton();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
