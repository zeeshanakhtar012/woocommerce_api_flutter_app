import 'package:zrj/model/product.dart';

class PopularProduct {
  String? status;
  List<Product>? data;
  PopularProduct({this.status, this.data,});
  PopularProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
  }
}
