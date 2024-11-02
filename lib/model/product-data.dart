
import 'package:zrj/model/product.dart';

class GetAllProduct {
  String? status;
  Data data;
  List<int>? wishlist = [];
  List<int>? cart = [];

  GetAllProduct({
    required this.status,
    required this.data,
    required this.wishlist,
    required this.cart,

    // required this.wishListProduct,
  });

  factory GetAllProduct.fromJson(Map<String, dynamic> json) {
    print(" the json ${json}");
    return GetAllProduct(
      status: json['status'] as String?,
      data: Data.fromJson(json['data']),
      wishlist:json['wishlist'] != null ? List<int>.from(json['wishlist']) : [],
      cart: json['cart'] != null ? List<int>.from(json['cart']) : [],
    );
  }
}

class Data {
  int currentPage;
  List<Product> data;
  String? firstPageUrl;
  int from;
  int lastPage;
  String? lastPageUrl;
  List<Link> links;
  String? nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      data: List<Product>.from(json['data'].map((x) => Product.fromJson(x))),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'] as String?,
      links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}




class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'] as String?,
      label: json['label'],
      active: json['active'],
    );
  }
}
