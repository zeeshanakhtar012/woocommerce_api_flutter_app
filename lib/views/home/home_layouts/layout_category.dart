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
    productsController.fetchCategories();
    log("Categories fetched successfully ${productsController.categoryList}");
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
          Expanded(
            child: Obx(() {
              return RefreshIndicator(
                onRefresh: () async {
                  return await Future.delayed(Duration(seconds: 2));
                },
                color: Colors.white,
                backgroundColor: Colors.black,
                child: productsController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : _buildCategoryList(),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Refresh function: Calls fetchCategories when user pulls down
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    await productsController.fetchCategories();
  }

  // Builds the category list
  Widget _buildCategoryList() {
    if (productsController.categoryList.isEmpty) {
      return Center(child: Text('No categories available'));
    }

    return ListView.builder(
      itemCount: productsController.categoryList.length,
      itemBuilder: (context, index) {
        final category = productsController.categoryList[index];
        return CustomImageCard(
          imagePath: category.image != null
              ? category.image!
              : 'assets/images/default_image.png',
          title: category.name,  // Access name directly from Category
          onTap: () {
            productsController.selectCategory(category.id.toString());
            log("Category Name ${category.name}");
            Get.to(() => ProductsListScreen(categoryName: category.name));
          },
        );
      },
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
        margin: EdgeInsets.all(8.sp),
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.07),
              spreadRadius: 2,
              blurRadius: 2,
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
                  image: imagePath.startsWith('http')
                      ? NetworkImage(imagePath)
                      : AssetImage(imagePath) as ImageProvider,
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
