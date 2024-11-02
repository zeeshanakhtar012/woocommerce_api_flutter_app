import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:zrj/constants/colors.dart';
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
      title: "Welcome",
      description: "This is the first intro screen",
      imagePath: "assets/images/image_intro_01.svg",
      currentIndex: 0,
    ),
    _buildSlide(
      title: "Discover",
      description: "This is the second intro screen",
      imagePath: "assets/images/image_intro_02.svg",
      currentIndex: 1,
    ),
    _buildSlide(
      title: "Get Started",
      description: "This is the third intro screen",
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
      duration: Duration(
        seconds: 4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Align(
                alignment: Alignment.center,
                child: AnimatedSvg(svgAssetPath: imagePath,color: Colors.black,)),
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
      Get.offAll(ScreenLogin());
    }
  }

  void _onSkip() {
    Get.offAll(ScreenLogin());
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
              duration: Duration(
                seconds: 4,
              ),
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: List.generate(_slides.length, (index) {
                  return AnimatedContainer(
                    curve: Curves.linearToEaseOut,
                    duration: Duration(
                      seconds: 4,
                    ),
                    child: _buildSlide(
                      title: [
                        "START YOUR SHOPPING JOURNEY",
                        "FIND WHAT YOU LOVE",
                        "FAST AND RELIABLE DELIVERY"
                      ][index],
                      description: [
                        "Explore Thousands of Products Tailored\nJust For You.",
                        "Brows and Discover Products That Match\nYour Style and Needs.",
                        "Get Your Orders Delivered Quickly and\nSecurely To Your Doorstep."
                      ][index],
                      imagePath: [
                        "assets/images/image_intro_01.svg",
                        "assets/images/image_intro_02.svg",
                        "assets/images/image_intro_03.svg"
                      ][index],
                      currentIndex: _currentIndex,
                    ),
                  );
                }),
              ),
            ),
          ),
          AnimatedContainer(
            curve: Curves.linearToEaseOut,
            duration: Duration(
              seconds: 4,
            ),
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
                  "SKIP",
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
                    color: AppColors.appRedColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    "Next",
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
          duration: Duration(
            seconds: 4,
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0.w),
            width: currentIndex == index ? 23.w : 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              shape:
                  currentIndex == index ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  currentIndex == index ? BorderRadius.circular(20) : null,
              color:
                  currentIndex == index ? Color(0xff002654) : Color(0xFFA7A7A7),
            ),
          ),
        );
      }),
    );
  }
}
