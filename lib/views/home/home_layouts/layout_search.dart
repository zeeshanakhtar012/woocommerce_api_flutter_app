import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';

import '../../../widgets/custom_field_search.dart';
import 'layout_cart.dart';

class CustomProduct {
  final String name;

  final String imagePath;
  final String price;
  final String color;
  final String size;

  CustomProduct({
    required this.name,

    required this.imagePath,
    required this.price,
    required this.color,
    required this.size,
  });
}

class DressItemCard extends StatelessWidget {
  final CustomProduct product;

  DressItemCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Clip the content
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade200], // Gradient background
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 120.sp,
                child: Image.network(
                  product.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 16.sp, // Responsive text size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
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

// Main LayoutSearch screen
class LayoutSearch extends StatefulWidget {
  @override
  _LayoutSearchState createState() => _LayoutSearchState();
}

class _LayoutSearchState extends State<LayoutSearch> {
  List<CustomProduct> products = [];
  List<CustomProduct> filteredProducts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    products = [
      CustomProduct(
        name: 'Clothes',
        imagePath: 'https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: "50",
        color: "red",
        size: "M",
      ),
      CustomProduct(
        name: 'Shoes',
        imagePath: 'https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: "80",
        color: "blue",
        size: "L",
      ),
      CustomProduct(
        name: 'Hat',
        imagePath: 'https://images.unsplash.com/photo-1651047566242-1f93897b907a?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        price: "20",
        color: "green",
        size: "S",
      ),
      // Add more products as needed
    ];
    filteredProducts = products;
  }

  void filterProducts(String query) {
    if (query.isNotEmpty) {
      filteredProducts = products
          .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredProducts = products;
    }
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: Get.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 80.h,
                left: 132.w,
                right: 91.w,
                child: SvgPicture.asset(
                  "assets/icons/home_line.svg",
                  color: Colors.black.withOpacity(.2),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                top: 0,
                left: 0,
                child: RefreshIndicator(
                  color: Colors.red, // Change this to your primary color
                  onRefresh: () async {
                    return await Future.delayed(Duration(seconds: 2));
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomTextFieldSearch(
                            width: Get.width/1.35,
                            hintText: 'Search',
                            suffixIcon: Container(
                              height: 20.h,
                              width: 65.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.buttonColor,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ), onChanged: (value) => filterProducts(value),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => LayoutCart(isHome: true,));
                            },
                            child: CircleAvatar(
                              radius: 23.r,
                              backgroundColor:AppColors.buttonColor,
                              child: SvgPicture.asset("assets/icons/icon_store.svg"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${filteredProducts.length} items found",
                            style: TextStyle(
                              color: Color(0xff002654),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 10,left: 10),
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.only(top: 20.h, bottom: 60.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.w,
                            mainAxisSpacing: 20.h,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DressItemCard(
                              product: filteredProducts[index],
                            );
                          },
                        ),
                      ),
                    ],
                  ).marginSymmetric(horizontal: 10.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
