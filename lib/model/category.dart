import 'dart:convert';
import 'package:zrj/model/product.dart';

class Category {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final int? productsCount;
  final List<Product>? products;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.productsCount,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    // Parse the nested `image` field if it exists
    String? imageUrl;
    if (json['image'] != null && json['image'] is Map<String, dynamic>) {
      imageUrl = json['image']['src'];  // Assuming image has a 'src' field
    }

    return Category(
      id: json['id'] ?? 0,  // Default to 0 if `id` is null
      name: json['name'] ?? '',  // Default to an empty string if `name` is null
      description: json['description'],  // Null allowed for description
      image: imageUrl,  // `image` will be null if not available
      productsCount: json['count'] ?? 0,  // Default to 0 if `count` is null
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : [],  // Default to empty list if `products` is null
    );
  }
}
