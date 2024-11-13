

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zrj/controllers/controller_authentication.dart';
import 'package:zrj/views/home/home_layouts/layout_profile.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_product.dart';
import '../../../model/category.dart';
import '../../../model/product.dart';
import '../../../widgets/custom_field_search.dart';
import '../../../widgets/skeleton/custom_skeleton.dart/cart_skeleton.dart';
import '../../screens/screen_product.dart';
import '../../screens/test.dart';
import 'layout_cart.dart';

class LayoutHome extends StatelessWidget {

  // Filter states
  final _FilterController filterController = Get.put(_FilterController());
  ProductWooCommerceController controller =
      Get.put(ProductWooCommerceController());
  Category? category;
  ControllerAuthentication auth = Get.find();
  @override
  Widget build(BuildContext context) {
    final String demoImage = "https://picsum.photos/250";
    controller.fetchCategories();
    log("Categories = ${controller.categoryList.length}");
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomTextFieldSearch(
                        width: Get.width * .75,
                        hintText: 'Search',
                        suffixIcon: Container(
                          height: 20.h,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.buttonColor,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Get.to(() => LayoutProfile());
                         await auth.fetchUserIdByToken();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25.r,
                          backgroundImage: NetworkImage(demoImage),
                        ).marginSymmetric(vertical: 6.h),
                      ),
                    ],
                  ).marginSymmetric(horizontal: 10),
                  buildTitle("Categories").marginOnly(top: 10.h, left: 25.w),

                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.categoryList.isEmpty) {
                      return Center(child: Text("No categories available"));
                    } else {
                      return SizedBox(
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categoryList.length,
                          itemBuilder: (context, index) {
                            var category = controller.categoryList[index];
                            return GestureDetector(
                              onTap: () {
                                if (category != null) {
                                  controller.selectCategory(
                                      "${category.id ?? ''}");
                                  log("Category Name ${category.name}");
                                  Get.to(() => ProductsListScreen(
                                      categoryName: category.name));
                                }
                              },
                              child: buildCategoryItem(category)
                                  .marginOnly(
                                  left: index == 0 ? 20.w : 10.w),
                            );
                          },
                        ),
                      );
                    }
                  }),

              buildTitle("Sale Discount").marginOnly(top: 10.h, left: 25.w),
              Obx(() {
                return controller.filteredProductList.isEmpty
                    ? buildSkeletonList()
                    : Column(
                  children: List.generate(
                    controller.filteredProductList.length,
                        (index) {
                      return buildSaleBannerItem(
                          controller.filteredProductList[index], category)
                          .marginOnly(top: 10.h);
                    },
                  ),
                );
              }),

                  SizedBox(height: 80),
                ],
              ).marginSymmetric(vertical: 10.h),
            ),
          ),
        ),
      ),
    );
  }

  // Method to handle refresh
  Future<void> _onRefresh() async {
    controller.fetchCategories();
    await Future.delayed(Duration(seconds: 1));
  }

  // Category item widget
  Widget buildCategoryItem(Category category) {
    return Container(
      width: 200.w,
      height: 250.h,
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withOpacity(
            0), // Make the background transparent so the blur effect is visible
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              // Apply the blur effect to the background image
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(category.image ?? ''),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Text(
            category.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // White text to stand out on the blurry background
              fontSize: 16.sp,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.7),
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Sale discount banner item widget
  Widget buildSaleBannerItem(Product product, Category? category ) {
    return InkWell(
      onTap: () {
        if (category != null) {
          controller.selectCategory(
              "${category.id ?? ''}");
          log("Category Name ${category.name}");
          Get.to(() => ProductsListScreen(
              categoryName: category.name));
        }
      },
      child: Container(
        width: Get.width - 40.w,
        height: 150.h,
        padding: EdgeInsets.all(12.sp),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(product.images![0].src ?? ''),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                  height: 50.h,
                  width: 50.w,
                  "assets/images/new.png"),
            ),
            Text(
              product.name!,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${product.price}',
              style: TextStyle(color: Colors.yellowAccent, fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Text buildTitle(String title) => Text(
        title,
        style: AppFontsStyle.introScrTitle.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          fontFamily: "AvenirBlack",
        ),
      );

  // Helper widget to build skeleton list
  Widget buildSkeletonList() {
    return Row(
      children: List.generate(3, (index) {
        return CartSkeleton(
          height: 150.h,
        ).marginOnly(left: 20.w, top: 10.h);
      }),
    );
  }
}

class _FilterController extends GetxController {
  var selectedCategories = <String>[].obs;
  var selectedColors = <String>[].obs;

  final List<String> categories = ["Electronics", "Clothing", "Home"];
  final List<String> colors = ["Red", "Blue", "Green", "Black", "White"];

  void addCategory(String category) {
    if (!selectedCategories.contains(category)) {
      selectedCategories.add(category);
    } else {
      selectedCategories.remove(category);
    }
  }

  void addColor(String color) {
    if (!selectedColors.contains(color)) {
      selectedColors.add(color);
    } else {
      selectedColors.remove(color);
    }
  }
}

