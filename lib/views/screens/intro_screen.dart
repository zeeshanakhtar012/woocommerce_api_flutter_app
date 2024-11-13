import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';
import 'package:zrj/views/screens/authentication_screens/screen_signup.dart';
import 'package:zrj/views/screens/screen_test.dart';
import 'authentication_screens/screen_login.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _slides = [
    _buildSlide(
      title: 'intro_start_your_shopping'.tr,
      description: 'intro_explore_products'.tr,
      imagePath: "assets/images/image_intro_01.svg",
      currentIndex: 0,
    ),
    _buildSlide(
      title: 'intro_find_what_you_love'.tr,
      description: 'intro_browse_products'.tr,
      imagePath: "assets/images/image_intro_02.svg",
      currentIndex: 1,
    ),
    _buildSlide(
      title: 'intro_fast_delivery'.tr,
      description: 'intro_get_orders_delivered'.tr,
      imagePath: "assets/images/image_intro_03.svg",
      currentIndex: 2,
    ),
  ];

  static Widget _buildSlide({
    required String title,
    required String description,
    required String imagePath,
    required int currentIndex,
  }) {
    return AnimatedContainer(
      curve: Curves.linearToEaseOut,
      duration: Duration(seconds: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Align(
                alignment: Alignment.center,
                child: AnimatedSvg(svgAssetPath: imagePath, color: Colors.black)),
            height: 300.h,
            width: (currentIndex == 0 || currentIndex == 1) ? 200.w : Get.width,
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            style: TextStyle(
              color: Color(0xff002654),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ).marginOnly(
            top: 15.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.sp,
            ),
            child: Column(
              children: [
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff002654),
                  ),
                ).marginOnly(
                  top: 10.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onNext() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeIn,
      );
    } else {
      Get.offAll(ScreenSignUp());
    }
  }

  void _onSkip() {
    Get.offAll(ScreenSignUp());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimatedContainer(
              curve: Curves.easeIn,
              duration: Duration(seconds: 4),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: _slides,
              ),
            ),
          ),
          AnimatedContainer(
            curve: Curves.linearToEaseOut,
            duration: Duration(seconds: 4),
            child: PageIndicator(currentIndex: _currentIndex).marginOnly(
              bottom: 100.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _onSkip,
                child: Text(
                  'intro_skip'.tr,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff002654),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _onNext,
                child: Container(
                  height: 60.h,
                  width: 150.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.buttonColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    'intro_next'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ).marginOnly(bottom: 30.h, left: 29.w, right: 29.w),
        ],
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentIndex;

  const PageIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedContainer(
          curve: Curves.linearToEaseOut,
          duration: Duration(seconds: 4),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            width: currentIndex == index ? 23.w : 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              shape: currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
              borderRadius: currentIndex == index ? BorderRadius.circular(20) : null,
              color: currentIndex == index ? Color(0xff002654) : Color(0xFFA7A7A7),
            ),
          ),
        );
      }),
    );
  }
}
