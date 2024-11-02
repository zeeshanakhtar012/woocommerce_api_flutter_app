import 'package:zrj/model/product.dart';

class ProductResponse {
  final String? status;
  final Product? data;
  final Cart? cart;

  ProductResponse({
    this.status,
    this.data,
    this.cart,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    print("check cart ${json['data']}");
    return ProductResponse(
      status: json['status'] as String?,
      data: json['data'] != null ? Product.fromJson(json['data']) : null,
      cart: json['cart'] != null ? Cart.fromJson(json['cart']) : null,
    );
  }
}

class Cart {
  final int? productId;
  final String? color;
  final String? size;
  final Pivot? cartPivot;

  Cart({
    this.productId,
    this.color,
    this.size,
    this.cartPivot,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      productId: json['product_id'] as int?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      cartPivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
}
