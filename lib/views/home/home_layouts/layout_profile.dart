import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_authentication.dart';
import '../../items/item_profile.dart';
import '../../layouts/layout_cart_tabs/screen_favourite_product.dart';
import '../../layouts/layout_my_profile/layout_my_account.dart';
import '../../layouts/layout_my_profile/layout_my_address.dart';
import '../../layouts/layout_my_profile/layout_purchases.dart';
import '../../screens/language_selection_screen.dart';


// Profile Layout
class LayoutProfile extends StatefulWidget {
  LayoutProfile({super.key});

  @override
  State<LayoutProfile> createState() => _LayoutProfileState();
}

class _LayoutProfileState extends State<LayoutProfile> {
  final ControllerAuthentication controllerAuth = Get.put(ControllerAuthentication());
  String userEmail = '';
  String userNicename = '';
  String userDisplayName = '';

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('user_email') ?? 'Not available';
      userNicename = prefs.getString('user_nicename') ?? 'Not available';
      userDisplayName = prefs.getString('user_display_name') ?? 'Not available';
    });
  }

  @override
  Widget build(BuildContext context) {
    final String demoImage = "https://picsum.photos/250";
    log(userEmail);
    log(userNicename);
    log(userDisplayName);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Container(
                height: 285.h,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFFED2939),
                ),
              ),
              Positioned(
                top: 30.h,
                left: 26.w,
                right: 26.w,
                bottom: 0,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                          height: 60.h, "assets/images/app_logo_png.png"),
                      InkWell(
                        onTap: () {
                          // Full screen image logic here
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20.h),
                          height: 80.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40.r,
                            backgroundImage: NetworkImage(demoImage),
                          ).marginSymmetric(vertical: 6.h),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Edit image logic here
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Edit",
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(width: 3.w),
                            SvgPicture.asset("assets/icons/edit.svg")
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          // Display user details here
                          Text(
                            userNicename,
                            style: AppFontsStyle.profileName,
                          ).marginOnly(bottom: 5.h, top: 8.h),
                          Text(
                            userEmail,
                            style: AppFontsStyle.profileEmail,
                          ).marginOnly(bottom: 5.h),
                        ],
                      ),

                      ItemProfile(
                        backgroundColor: Colors.white,
                        title: 'my_account'.tr,
                        imageUrl: "assets/icons/profile-icon.svg",
                        onTap: () {
                          Get.to(LayoutMyAccount());
                        },
                      ),
                      // ItemProfile(
                      //   title: 'my_address'.tr,  // Use translation key
                      //   backgroundColor: Colors.white,
                      //   imageUrl: "assets/icons/Location_Icon.svg",
                      //   onTap: () {
                      //     Get.to(LayoutAddress());
                      //   },
                      // ),
                      ItemProfile(
                        backgroundColor: Colors.white,
                        title: 'my_purchases'.tr,  // Use translation key
                        imageUrl: "assets/icons/order.svg",
                        onTap: () {
                          Get.to(LayoutPurchases());
                        },
                      ),
                      ItemProfile(
                        backgroundColor: Colors.white,
                        title: 'my_favourites'.tr,  // Use translation key
                        imageUrl: "assets/icons/fav.svg",
                        onTap: () {
                          Get.to(ScreenFavouriteProduct());
                        },
                      ),
                      ItemProfile(
                        backgroundColor: Colors.white,
                        title: 'logout'.tr,  // Use translation key
                        imageUrl: "assets/icons/logout.svg",
                        onTap: () async {
                          Get.defaultDialog(
                            backgroundColor: Colors.white,
                            title: "alert".tr,  // Use translation key
                            confirmTextColor: Colors.white,
                            middleText: "are_you_sure_logout".tr,  // Use translation key
                            confirm: TextButton(
                              onPressed: () async {
                                await controllerAuth.logoutUser();
                              },
                              child: Text(
                                "proceed".tr,  // Use translation key
                                style:
                                TextStyle(color: AppColors.appPrimaryColor),
                              ),
                            ),
                            cancel: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.appPrimaryColor,
                              ),
                              child: Text(
                                "cancel".tr,  // Use translation key
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                      ItemProfile(
                        isLanguage: true,
                        backgroundColor: Color(0xff002654, ),
                        title: 'change_language'.tr,  // Use translation key
                        imageUrl: "assets/icons/icon_fee_svg.svg",
                        onTap: () {
                          Get.to(() => LanguageSelectionScreen());
                        },
                      ),
                      SizedBox(height: 60.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
