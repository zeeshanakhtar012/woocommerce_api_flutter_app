 

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart'; 

class ItemDressCategory extends StatelessWidget {
  final String? backgroundImageUrl;
  final String title;
  final VoidCallback? onTap;

  ItemDressCategory({
    required this.title,
    this.backgroundImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,
        margin: EdgeInsets.symmetric(vertical: 6.5.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          image: DecorationImage(
            fit: BoxFit.cover,
            // image: NetworkImage(backgroundImageUrl!),
              image: CachedNetworkImageProvider(backgroundImageUrl!),
            
          )
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(  
          child: Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(15.r),
             color: Colors.black.withOpacity(.5),
           ),
          ),
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
