import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int? currentIndex;
  final bool hasNotification;
  final bool hasRequestNotification;
  final bool hasChatNotification;
  final Function(int) onItemTapped;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? backgroundColor;

  CustomBottomNavigationBar({
    this.currentIndex,
    required this.hasChatNotification,
    required this.hasRequestNotification,
    required this.hasNotification,
    required this.onItemTapped,
    this.selectedColor,
    this.unselectedColor,
    this.backgroundColor,
  });

  Widget _buildBottomNavigationItem({
    required String icon,
    required int index,
    bool hasNotification = false,
  })
  {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 300),
        tween: Tween<double>(begin: .9, end: isSelected ? 1.1 : .9),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: SvgPicture.asset(
              icon,
              color: isSelected ? selectedColor : unselectedColor,
              height: 20.h,
              width: 20.w,
              placeholderBuilder: (BuildContext context) => Container(
                padding: EdgeInsets.all(30.h),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35), // Adjust the radius as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildBottomNavigationItem(
            icon: "assets/icons/icon_home.svg",
            index: 0,
          ),
          _buildBottomNavigationItem(
            icon: "assets/icons/icon_search.svg",
            index: 1,
            hasNotification: hasNotification,
          ),
          _buildBottomNavigationItem(
            icon: "assets/icons/icon_category.svg",
            index: 2,
          ),
          _buildBottomNavigationItem(
            icon: "assets/icons/icon_cart.svg",
            hasNotification: hasChatNotification,
            index: 3,
          ),
          _buildBottomNavigationItem(
            icon: "assets/icons/icon_profile.svg",
            index: 4,
            hasNotification: hasRequestNotification,
          ),
        ],
      ),
    ).marginSymmetric(horizontal: 32.w, vertical: 10.h);
  }
}
