import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../controllers/controller_product.dart';
import '../../screens/screen_product.dart';

class LayoutCategory extends StatelessWidget {
  final ProductWooCommerceController productsController = Get.put(ProductWooCommerceController());

  @override
  Widget build(BuildContext context) {
    // Fetch categories and products when the screen is loaded
    productsController.fetchCategories();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text(
          "Categories",
          style: AppFontsStyle.profileAppBar.copyWith(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Fetch categories dynamically from the API and display them
          Expanded(
            child: Obx(() {
              if (productsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (productsController.categoryList.isEmpty) {
                return Center(child: Text('No categories available'));
              }

              return ListView.builder(
                itemCount: productsController.categoryList.length,
                itemBuilder: (context, index) {
                  final category = productsController.categoryList[index];
                  return CustomImageCard(
                    imagePath: category['image'] != null ? category['image']['src'] : 'assets/images/default_image.png',
                    title: category['name'],
                    onTap: () {
                      productsController.selectCategory(category['id'].toString());
                      log("Category Name ${category['name']}");
                      Get.to(() => ProductsListScreen(categoryName: category['name']));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class CustomImageCard extends StatelessWidget {
  const CustomImageCard({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 250.sp,
        // height: 150.sp,
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  image: imagePath.startsWith('http') ? NetworkImage(imagePath) : AssetImage(imagePath) as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 8.sp,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}