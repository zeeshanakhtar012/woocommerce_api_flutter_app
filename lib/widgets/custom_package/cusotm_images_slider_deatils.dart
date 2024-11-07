
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../model/product.dart';
import '../custom_add_cart_container.dart';
import '../skeleton/custom_skeleton.dart/image_skeleton.dart';

class SlidingImageContainer extends StatefulWidget {
  final Product product;

  @override
  _SlidingImageContainerState createState() => _SlidingImageContainerState();

  const SlidingImageContainer({
    required this.product,
  });
}

class _SlidingImageContainerState extends State<SlidingImageContainer> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        width: width,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.product.images!.length,
                itemBuilder: (context, index) {
                  final imageUrl = widget.product.images[index].src;
                  return Container(
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        placeholder: (context, url) => ImageSkeleton(
                          height: Get.height / 2 + 50,
                          width: width,
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text(
                            'No Image Available',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 10.h,
              right: 15.w,
              child: CustomContainer(
                productId: widget.product.id.toString(), // Example of setting productId dynamically
                isInWishlist: true,
                onToggleWishlist: (String) {},
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.product.images!.length,
                        (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.sp),
                      width: 8.sp,
                      height: 8.sp,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Color(0xFF57636F)
                            : Color(0xFFDADADA),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
