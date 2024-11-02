import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import 'home_layouts/layout_cart.dart';
import 'home_layouts/layout_category.dart';
import 'home_layouts/layout_home.dart';
import 'home_layouts/layout_profile.dart';
import 'home_layouts/layout_search.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> tabs = [
    LayoutHome(),
    LayoutSearch(),
    LayoutCategory(),
    LayoutCart(isHome: true),
    LayoutProfile(),
  ];

  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          _changeTab(0); // Go to the home tab instead of exiting
          return false;
        }
        return true; // Exit the app
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          bottom: false,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: tabs,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 31.w),
          height: 60.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35.r),
            color: Colors.white,
            boxShadow: [AppColors.myCustomBoxShadow],
          ),
          child: NavigationBar(
            animationDuration: Duration(milliseconds: 300),
            backgroundColor: Colors.transparent,
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.r),
            ),
            destinations: [
              _buildBottomNavigationItem("assets/icons/icon_home.svg", 0),
              _buildBottomNavigationItem("assets/icons/icon_search.svg", 1),
              _buildBottomNavigationItem("assets/icons/icon_category.svg", 2),
              _buildBottomNavigationItem("assets/icons/icon_cart.svg", 3),
              _buildBottomNavigationItem("assets/icons/icon_profile.svg", 4),
            ],
            selectedIndex: currentIndex,
          ).marginSymmetric(horizontal: 12),
        ),
      ),
    );
  }

  void _changeTab(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index); // Jump to the selected tab
    });
  }

  Widget _buildBottomNavigationItem(String icon, int index) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () {
        _changeTab(index); // Update the current index and switch tab
      },
      child: SvgPicture.asset(
        icon,
        color: isSelected ? Color(0xff002654) : AppColors.appGreyColor,
        height: 20.h,
        width: 20.w,
        fit: BoxFit.contain,
        placeholderBuilder: (BuildContext context) =>
            CircularProgressIndicator(),
      ).marginOnly(right: index != 4 ? 24.w : 0.0),
    );
  }
}
