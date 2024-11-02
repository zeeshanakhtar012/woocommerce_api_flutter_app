import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/colors.dart';
import '../../constants/fonts.dart';

// ignore: must_be_immutable
class ItemProfile extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final Icon? icon;
  final bool? isLanguage; // Change this to non-nullable if you have a default value
  final Color? backgroundColor;
  final VoidCallback onTap;

  ItemProfile({
    required this.title,
    this.imageUrl,
    this.icon,
    this.isLanguage, // Make sure to handle null if you keep it nullable
    this.backgroundColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor;
    if (isLanguage == true) {
      textColor = Colors.white;
    } else {
      textColor = backgroundColor == Color(0xff4C6042) ? Colors.white : Colors.black;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 62.h,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.only(left: 28.w),
        decoration: BoxDecoration(
          boxShadow: [AppColors.myCustomBoxShadow],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              title,
              style: AppFontsStyle.profileDetails.copyWith(color: textColor),
            ),
            leading: icon != null
                ? icon
                : imageUrl != null
                ? SvgPicture.asset(
              imageUrl!,
              fit: BoxFit.cover,
            )
                : null,
          ),
        ),
      ),
    );
  }
}
