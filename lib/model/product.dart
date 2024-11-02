class Product {
  int? id;
  String? name;
  String? styleNumber;
  String? price;
  String? salePrice;
  List<String>? sizes;
  List<String>? colors;
  String? description;
  int? designerId;
  int? isNew;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? tags;
  String? discountPercentage;
  int? discountStatus;
  dynamic subcategoryId;
  String? nameAr;
  String? descriptionAr;
  int? quantity;
  dynamic contentEn;
  dynamic contentAr;
  Pivot? pivot;
  List<Images>? images;
  List<Category>? categories;
  Designer? designer;

  Product({
    this.id,
    this.name,
    this.styleNumber,
    this.price,
    this.salePrice,
    this.sizes,
    this.colors,
    this.description,
    this.designerId,
    this.isNew,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.discountPercentage,
    this.discountStatus,
    this.subcategoryId,
    this.nameAr,
    this.descriptionAr,
    this.quantity,
    this.contentEn,
    this.contentAr,
    this.pivot,
    this.images,
    this.categories,
    this.designer,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        styleNumber: json["style_number"],
        price:
            json["price"] != null ? json["price"].split('.')[0] : json["price"],
        salePrice: json["sale_price"],
        sizes: json["sizes"] == null
            ? []
            : List<String>.from(json["sizes"]!.map((x) => x)),
        colors: json["colors"] == null
            ? []
            : List<String>.from(json["colors"]!.map((x) => x)),
        description: json["description"],
        designerId: json["designer_id"],
        isNew: json["is_new"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        discountPercentage: json["discount_percentage"],
        discountStatus: json["discount_status"],
        subcategoryId: json["subcategory_id"],
        nameAr: json["name_ar"],
        descriptionAr: json["description_ar"],
        quantity: json["quantity"],
        contentEn: json["content_en"],
        contentAr: json["content_ar"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        images: json["images"] == null
            ? []
            : List<Images>.from(json["images"]!.map((x) => Images.fromJson(x))),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        designer: json["designer"] == null
            ? null
            : Designer.fromJson(json["designer"]),
      );
}

class Images {
  int? id;
  int? productId;
  String? imagePath;
  DateTime? createdAt;
  DateTime? updatedAt;

  Images({
    this.id,
    this.productId,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        id: json["id"],
        productId: json["product_id"],
        imagePath: json["image_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class Pivot {
  int? wishlistId;
  int? productId;
  int? quantity;
  String? price;
  dynamic color;
  dynamic size;
  DateTime? createdAt;
  DateTime? updatedAt;

  Pivot({
    this.wishlistId,
    this.productId,
    this.quantity,
    this.color,
    this.size,
    this.createdAt,
    this.updatedAt,
    this.price,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        wishlistId: json["wishlist_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        color: json["color"],
        size: json["size"],
        price: json["price"] == null ? '' : json["price"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}

class Category {
  final int? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final String? image;
  final String? nameAr;
  final String? descriptionAr;
  final Pivot? pivot;

  Category({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.nameAr,
    this.descriptionAr,
    this.pivot,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      nameAr: json['name_ar'] as String?,
      descriptionAr: json['description_ar'] as String?,
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
}

class Designer {
  int id;
  String? fName;
  String? lName;
  String? email;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic city;
  dynamic phoneNumber;
  int verified;
  dynamic otp;
  DateTime createdAt;
  DateTime updatedAt;
  String username;
  dynamic image;

  Designer({
    required this.id,
    required this.fName,
    required this.lName,
    required this.email,
    required this.emailVerifiedAt,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.verified,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
    required this.username,
    required this.image,
  });

  factory Designer.fromJson(Map<String, dynamic> json) {
    return Designer(
      id: json['id'],
      fName: json['f_name'] as String?,
      lName: json['l_name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'],
      address: json['address'],
      city: json['city'],
      phoneNumber: json['phone_number'],
      verified: json['verified'],
      otp: json['otp'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      username: json['username'],
      image: json['image'],
    );
  }
}
