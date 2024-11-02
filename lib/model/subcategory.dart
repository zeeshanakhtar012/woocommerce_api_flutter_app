import 'category.dart';

class Subcategory {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final String? image;
  final String createdAt;
  final String updatedAt;
  final Category category;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      category: Category.fromJson(json['category']),
    );
  }
}
