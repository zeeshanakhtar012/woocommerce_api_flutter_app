import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zrj/views/screens/screen_products_details.dart';
import '../../controllers/controller_product.dart';
import '../../model/product.dart';

class ProductsListScreen extends StatelessWidget {
  final String categoryName;

  ProductsListScreen({required this.categoryName});

  final ProductWooCommerceController productsController = Get.put(ProductWooCommerceController());

  @override
  Widget build(BuildContext context) {
    log("categoryName = $categoryName");
    productsController.fetchProductsByCategory(categoryName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: Colors.red,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ).marginSymmetric(
            horizontal: 10.sp,
            vertical: 10.sp,
          ),
        ),
        title: Text(
          '$categoryName',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (productsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (productsController.filteredProductList.isEmpty) {
                return Center(child: Text('No products available in this category'));
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.68,
                  ),
                  itemCount: productsController.filteredProductList.length,
                  itemBuilder: (context, index) {
                    final Product product = productsController.filteredProductList[index];
                    return InkWell(
                      onTap: () {
                        String stripHtml(String htmlString) {
                          final RegExp htmlTag = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
                          return htmlString.replaceAll(htmlTag, '').replaceAll('\n', ' ').trim();
                        }
                        String plainTextDescription = stripHtml(product.description!);
                        Get.to(() => ScreenProductDetails(
                          productId: product.id,
                          productDescription: plainTextDescription,
                          productName: product.name!,
                          productPrice: product.price.toString(),
                          sizes: ['S', 'M', 'L'],
                          colors: ['Red', 'Blue', 'Green'],
                          productImages: product.images!.map((image) => image.src!).toList(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            product.images!.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.network(
                                product.images![0].src!,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Container(
                              height: 160,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                              ),
                              child: Icon(Icons.image, size: 80, color: Colors.grey[400]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name ?? 'No name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        'Price: \$${product.price ?? 'N/A'}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '(${product.categories![0].name ?? 'N/A'})',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
