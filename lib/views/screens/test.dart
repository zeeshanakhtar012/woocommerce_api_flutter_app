import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/controller_product.dart';

class ProductsScreen extends StatelessWidget {
  final ProductWooCommerceController productsController = Get.put(ProductWooCommerceController());

  @override
  Widget build(BuildContext context) {
    productsController.fetchCategories();
    print("categoryList ${productsController.categoryList.length}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: Column(
        children: [
          // Category Selector
          Obx(() {
            if (productsController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            if (productsController.categoryList.isEmpty) {
              return Center(child: Text('No categories available'));
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productsController.categoryList.map((category) {
                  return GestureDetector(
                    onTap: () {
                      productsController.selectCategory(category.id.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: productsController.selectedCategory.value == category.id.toString()
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          category.imageUrl.isNotEmpty
                              ? Image.network(category.imageUrl, height: 40, width: 40)
                              : SizedBox.shrink(),
                          SizedBox(width: 10),
                          Text(
                            category.name,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }),

          // Products List
          Expanded(
            child: Obx(() {
              if (productsController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (productsController.products.isEmpty) {
                return Center(
                  child: Text('No products available for this category'),
                );
              } else {
                return ListView.builder(
                  itemCount: productsController.products.length,
                  itemBuilder: (context, index) {
                    final product = productsController.products[index];
                    return ListTile(
                      leading: product.images.isNotEmpty
                          ? Image.network(product.images[0]['src'], height: 50, width: 50)
                          : SizedBox.shrink(),
                      title: Text(product.name),
                      subtitle: Text('Price: \$${product.price}'),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
