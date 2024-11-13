import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zrj/constants/colors.dart';
import 'package:zrj/model/product.dart';

import '../../../controllers/controller_product.dart';
import '../../../widgets/custom_field_search.dart';
import 'layout_cart.dart';

class DressItemCard extends StatelessWidget {
  final Product product;

  DressItemCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Clip the content
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade200],
              // Gradient background
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
                  product.images![0].src ?? '',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                child: Text(
                  product.name!,
                  style: TextStyle(
                    fontSize: 16.sp, // Responsive text size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
                child: Text(
                  "Total Sales ${product.totalSales}",
                  style: TextStyle(
                    fontSize: 16.sp, // Responsive text size
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 4.0),
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
  List<Product> products = [];
  String searchQuery = "";
  ProductWooCommerceController controller = Get.put(
      ProductWooCommerceController());

  @override
  Widget build(BuildContext context) {
    controller.fetchAllProducts();
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
                    controller.fetchAllProducts();
                    return await Future.delayed(Duration(seconds: 2));
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomTextFieldSearch(
                            width: Get.width / 1.35,
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
                            ),
                            onChanged: (value) =>
                                controller.filterProducts(value),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => LayoutCart(isHome: true,));
                            },
                            child: CircleAvatar(
                              radius: 23.r,
                              backgroundColor: AppColors.buttonColor,
                              child: SvgPicture.asset(
                                  "assets/icons/icon_store.svg"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${controller.filteredProductList
                                .length} items found",
                            style: TextStyle(
                              color: Color(0xff002654),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 10, left: 10),
                      Obx(() {
                        if(controller.isLoading.value){
                          return CircularProgressIndicator();
                        }
                         else if(controller.filteredProductList.isEmpty){
                           return Center(
                             child: Text("No Products found available"),
                           );
                        }else {
                          return Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.only(top: 20.h, bottom: 60.h),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 20.h,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: controller.filteredProductList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return DressItemCard(
                                  product: controller.filteredProductList[index],
                                );
                              },
                            ),
                          );
                        }
                      }),
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
