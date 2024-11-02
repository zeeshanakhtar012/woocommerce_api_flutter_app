
import 'package:zrj/model/product.dart';

class WishListModel {
  String? status;
  Wishlist? wishlist;
  Wishlist? cart;

  WishListModel({
    this.status,
    this.wishlist,
    this.cart,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    status: json["status"],
    wishlist: json["wishlist"] == null ? null : Wishlist.fromJson(json["wishlist"]),
    cart: json["cart"] == null ? null : Wishlist.fromJson(json["cart"]),
  );


}

class Wishlist {
  int? id;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic designerId;
  List<Product>? products;

  Wishlist({
    this.id,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.designerId,
    this.products,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    id: json["id"],
    userId: json["user_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    designerId: json["designer_id"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

}


