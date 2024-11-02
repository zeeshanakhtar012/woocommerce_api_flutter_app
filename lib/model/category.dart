import 'dart:convert';

import 'package:zrj/model/product.dart';

class Category {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final int? products_count;
  List<Subcategory?>? subcategories;
  final List<Product>? products;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.products_count,
    this.subcategories,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    String name;
    try {
      final dynamic nameField = json['name'];
      if (nameField is String && nameField.startsWith('["')) {
        List<dynamic> nameList = jsonDecode(nameField);
        name = nameList.join(', ');
      } else {
        name = nameField;
      }
    } catch (e) {
      name = json['name'];
    }

    // if (json['subcategories'] != null) {
    //   subcategories = <Subcategory>[];
    //   json['subcategories'].forEach((v) {
    //     subcategories!.add(Subcategory.fromJson(v));
    //   });
    // }

// print("Json ${json}");
    return Category(
      id: json['id'],
      name: name,
      description: json['description'],
      image: json['image'],
      products_count: json['products_count'],
      subcategories: null,
      products: json['products'] != null
          ? List<Product>.from(json['products'].map((x) => Product.fromJson(x)))
          : [],
    );
  }
}

class Subcategory {
  int? id;
  int? categoryid;
  String? name;
  String? description;
  String? image;
  DateTime? createdat;
  DateTime? updatedat;
  String? namear;
  String? descriptionar;

  Subcategory(
      {this.id,
      this.categoryid,
      this.name,
      this.description,
      this.image,
      this.createdat,
      this.updatedat,
      this.namear,
      this.descriptionar});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryid = json['category_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdat = json['created_at'];
    updatedat = json['updated_at'];
    namear = json['name_ar'];
    descriptionar = json['description_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['category_id'] = categoryid;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdat;
    data['updated_at'] = updatedat;
    data['name_ar'] = namear;
    data['description_ar'] = descriptionar;
    return data;
  }
}
