import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zrj/views/screens/screen_products_details.dart';

class ScreenProductsCategory extends StatelessWidget {
  final String category;

  const ScreenProductsCategory({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = getCategoryProducts(category);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categoryProducts.length,
        itemBuilder: (context, index) {
          final product = categoryProducts[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => ScreenProductDetails(
                productName: product.name,
                productPrice: product.price.toString(),
                sizes: ['S', 'M', 'L'], // Example sizes
                colors: ['Red', 'Blue', 'Green'], productImage: product.imageUrl, // Example colors
              ));
            },
            child: buildProductItem(product),
          );
        },
      ),
    );
  }

  List<Product> getCategoryProducts(String category) {
    // Replace this with your logic to fetch products based on the selected category
    return [
      Product(name: "Sample Product 1", price: 100.0, imageUrl: "https://example.com/image1.jpg"),
      Product(name: "Sample Product 2", price: 150.0, imageUrl: "https://example.com/image2.jpg"),
      // Add more sample products here
    ];
  }

  Widget buildProductItem(Product product) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.imageUrl, height: 100, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('\$${product.price.toStringAsFixed(2)}'),
          ),
        ],
      ),
    );
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
