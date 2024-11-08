import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zrj/views/screens/authentication_screens/screen_login.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../items/item_profile.dart';
import '../../layouts/layout_cart_tabs/screen_favourite_product.dart';
import '../../layouts/layout_my_profile/layout_my_account.dart';
import '../../layouts/layout_my_profile/layout_my_address.dart';
import '../../layouts/layout_my_profile/layout_purchases.dart';
import '../../screens/language_selection_screen.dart';

// Profile Controller
class ProfileController extends GetxController {
  var userName = "No User".obs;
  var userEmail = "anonymous@example.com".obs;

// Add methods to update user details as needed
}

// Profile Layout
class LayoutProfile extends StatelessWidget {
  LayoutProfile({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final String demoImage = "https://picsum.photos/250";

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
                          Text(
                            controller.userName.value,
                            style: AppFontsStyle.profileName,
                          ).marginOnly(bottom: 5.h, top: 8.h),
                          Text(
                            controller.userEmail.value,
                            style: AppFontsStyle.profileEmail,
                          ).marginOnly(bottom: 5.h),
                        ],
                      ),

                      ItemProfile(
                        backgroundColor: Colors.white,
                        title: 'my_account'.tr,  // Use translation key
                        imageUrl: "assets/icons/profile-icon.svg",
                        onTap: () {
                          Get.to(LayoutMyAccount());
                        },
                      ),
                      ItemProfile(
                        title: 'my_address'.tr,  // Use translation key
                        backgroundColor: Colors.white,
                        imageUrl: "assets/icons/Location_Icon.svg",
                        onTap: () {
                          Get.to(LayoutAddress());
                        },
                      ),
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
                              onPressed: () {
                                Get.to(ScreenLogin());
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
                        backgroundColor: Color(0xff002654,),
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
