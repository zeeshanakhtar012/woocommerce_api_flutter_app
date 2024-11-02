import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors.dart';
import '../../../constants/fonts.dart';
import '../../../widgets/custom_listview_builder.dart';
import '../../items/item_layout_category/item_layout_category/item_layout_category.dart';
import '../../screens/screen_product_subcategory.dart';

class LayoutCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text(
          "Categories",
          style: AppFontsStyle.profileAppBar.copyWith(fontSize: 14.sp),
        ),
        centerTitle: true,
      ),
      body: CustomListviewBuilder(
        scrollDirection: CustomDirection.vertical,
        itemCount: 10,
        itemBuilder: (context, index) {
          return ItemLayoutCategory(
            dressName: "Category $index", // Placeholder name
            dressImageUrl: 'https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            onTap: () {
              // Navigation logic can be added here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenProductSubcategory(
                    categoryID: index, // Placeholder category ID
                    categoryName: "Category $index", // Placeholder name
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
