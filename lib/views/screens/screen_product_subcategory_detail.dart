

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:zrj/model/product.dart';

import '../../constants/colors.dart';
import '../items/item_summer_special.dart';

class ScreenProductSubcategoryDetail extends StatelessWidget {
  final List<Product> product;
  final String subCategoryName;

  List<Product> searchProduct = [];
  TextEditingController textEditingController = TextEditingController();

  ScreenProductSubcategoryDetail({
    Key? key,
    required this.product,
    required this.subCategoryName,
  }) : super(key: key);

  void filterSearch(String query) {
    if (query.isEmpty) {
      searchProduct.assignAll(product);
    } else {
      searchProduct = product
          .where((product) =>
              product.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    filterSearch('');

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: Color(0xff4C6042),
            child: Icon(Icons.arrow_back, color: Colors.white),
          ).marginSymmetric(horizontal: 10.sp, vertical: 10.sp),
        ),
        title: Text(
          subCategoryName.toUpperCase(),
          style: TextStyle(color: Color(0xFF000000)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.only(top: 20.h),
                crossAxisCount: 4,
                itemCount: product.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = product[index];
                  return DressItemCard(product: item);
                },
                staggeredTileBuilder: (int index) =>
                    StaggeredTile.count(2, index.isEven ? 3.5 : 2.5),
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
            ),
          ],
        ).marginSymmetric(horizontal: 30.w),
      ),
    );
  }
}
