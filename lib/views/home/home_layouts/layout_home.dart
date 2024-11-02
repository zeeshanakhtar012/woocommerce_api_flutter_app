import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zrj/views/screens/screen_products_details.dart';

import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_field_search.dart';
import '../../../widgets/custom_listview_builder.dart';
import '../../../widgets/skeleton/custom_skeleton.dart/cart_skeleton.dart';
import 'layout_cart.dart';

class LayoutHome extends StatelessWidget {
  LayoutHome({super.key});

  final List<Product> sampleProducts = [
    Product(
        name: "Smartphone",
        price: 250.0,
        imageUrl:
            "https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Product(
        name: "Shoes",
        price: 40.0,
        imageUrl:
        "https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Product(
        name: "Chair",
        price: 35.0,
        imageUrl:
        "https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  ];

  final List<Product> sampleSalesDiscount = [
    Product(
        name: "Smartphone",
        price: 250.0,
        imageUrl:
        "https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Product(
        name: "Shoes",
        price: 40.0,
        imageUrl:
        "https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Product(
        name: "Chair",
        price: 35.0,
        imageUrl:
        "https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  ];

  // Filter states
  final _FilterController filterController = Get.put(_FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
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
                          color: Color(0xff4C6042),
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => LayoutCart(
                              isHome: true,
                            ));
                      },
                      child: CircleAvatar(
                        radius: 23.r,
                        backgroundColor: Color(0xff4C6042),
                        child: SvgPicture.asset("assets/icons/icon_store.svg"),
                      ).marginOnly(left: 5.w),
                    ),
                  ],
                ),
                buildTitle("Products").marginOnly(top: 10.h, left: 30.w),
                sampleProducts.isEmpty
                    ? buildSkeletonList()
                    : CustomListviewBuilder(
                        scrollDirection: CustomDirection.horizontal,
                        itemCount: sampleProducts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => ScreenProductDetails(
                                    productName: sampleProducts[index].name,
                                    productPrice:
                                        sampleProducts[index].price.toString(),
                                    sizes: ['S', 'M', 'L'], // Example sizes
                                    colors: [
                                      'Red',
                                      'Blue',
                                      'Green'
                                    ], // Example colors
                                  ));
                            },
                            child: buildProductItem(sampleProducts[index])
                                .marginOnly(left: index == 0 ? 30.w : 10.w),
                          );
                        },
                      ),
                buildTitle("Sale Discount").marginOnly(top: 10.h, left: 30.w),
                sampleSalesDiscount.isEmpty
                    ? buildSkeletonList()
                    : Column(
                        children:
                            List.generate(sampleSalesDiscount.length, (index) {
                          return buildSaleBannerItem(sampleSalesDiscount[index])
                              .marginOnly(top: 10.h);
                        }),
                      ),
                SizedBox(height: 80),
              ],
            ).marginSymmetric(vertical: 10.h),
          ),
        ),
      ),
    );
  }

  // Product item widget
  Widget buildProductItem(Product product) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.symmetric(vertical: 10.h),
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(product.imageUrl,
                height: 100.h, width: 130.w, fit: BoxFit.cover),
          ),
          SizedBox(height: 10.h),
          Text(
            product.name,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.green, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  // Sale discount banner item widget
  Widget buildSaleBannerItem(Product product) {
    return Container(
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
          image: NetworkImage(product.imageUrl),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            product.name,
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.yellowAccent, fontSize: 16.sp),
          ),
        ],
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
      children: List.generate(3, (index) => CartSkeleton(height: 150)).toList(),
    );
  }

  // Filter Bottom Sheet
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterBottomSheet(filterController: filterController);
      },
    );
  }
}

class FilterBottomSheet extends StatelessWidget {
  final _FilterController filterController;

  const FilterBottomSheet({Key? key, required this.filterController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Filter",
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),
            Text("Category", style: TextStyle(fontSize: 18.sp)),
            // Add categories here
            Obx(() {
              return Column(
                children: filterController.categories.map((category) {
                  return CheckboxListTile(
                    title: Text(category),
                    value:
                        filterController.selectedCategories.contains(category),
                    onChanged: (bool? value) {
                      if (value == true) {
                        filterController.addCategory(category);
                      } else {
                        filterController.removeCategory(category);
                      }
                    },
                  );
                }).toList(),
              );
            }),
            SizedBox(height: 20.h),
            Text("Color", style: TextStyle(fontSize: 18.sp)),
            // Add colors here
            Obx(() {
              return Column(
                children: filterController.colors.map((color) {
                  return CheckboxListTile(
                    title: Text(color),
                    value: filterController.selectedColors.contains(color),
                    onChanged: (bool? value) {
                      if (value == true) {
                        filterController.addColor(color);
                      } else {
                        filterController.removeColor(color);
                      }
                    },
                  );
                }).toList(),
              );
            }),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // Apply filters
                Get.back();
              },
              child: Text("Apply Filters"),
            ),
          ],
        ),
      ),
    );
  }
}

// Filter Controller
class _FilterController extends GetxController {
  var selectedCategories = <String>[].obs;
  var selectedColors = <String>[].obs;

  final List<String> categories = ["Electronics", "Clothing", "Home"];
  final List<String> colors = ["Red", "Blue", "Green", "Black", "White"];

  void addCategory(String category) {
    selectedCategories.add(category);
  }

  void removeCategory(String category) {
    selectedCategories.remove(category);
  }

  void addColor(String color) {
    selectedColors.add(color);
  }

  void removeColor(String color) {
    selectedColors.remove(color);
  }
}

// Product model class
class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
