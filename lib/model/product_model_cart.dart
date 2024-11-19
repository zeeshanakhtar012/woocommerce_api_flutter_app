class ProductModelCart {
  String? id;
  String? name;
  double? price;
  int? quantity;
  List<ProductImage>? images;

  // Updated constructor to include images
  ProductModelCart({
    this.id,
    this.name,
    this.price,
    this.quantity = 1, // Default quantity to 1
    this.images,
  });

  // Convert ProductModelCart to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id ?? '',
      'name': name ?? '',
      'price': price ?? 0.0,
      'quantity': quantity ?? 1,
      'images': images?.map((image) => image.toMap()).toList(),
    };
  }

  // Convert map to ProductModelCart object
  factory ProductModelCart.fromMap(Map<String, dynamic> map) {
    return ProductModelCart(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? 0.0,
      quantity: map['quantity'] ?? 1,
      images: map['images'] != null
          ? List<ProductImage>.from(
          map['images'].map((x) => ProductImage.fromMap(x)))
          : [],
    );
  }

  // Method to update the product quantity
  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }

  // You can also add a helper method to add more quantity
  void increaseQuantity(int increment) {
    quantity = (quantity ?? 0) + increment;
  }
}

class ProductImage {
  int? id;
  String? dateCreated;
  String? dateModified;
  String? src;
  String? name;
  String? alt;

  ProductImage({
    this.id,
    this.dateCreated,
    this.dateModified,
    this.src,
    this.name,
    this.alt,
  });

  // Convert ProductImage to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id ?? 0,
      'date_created': dateCreated ?? '',
      'date_modified': dateModified ?? '',
      'src': src ?? '',
      'name': name ?? '',
      'alt': alt ?? '',
    };
  }

  // Convert JSON to ProductImage object
  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'] as int? ?? 0,
      dateCreated: json['date_created'] as String? ?? '',
      dateModified: json['date_modified'] as String? ?? '',
      src: json['src'] as String? ?? '',
      name: json['name'] as String? ?? '',
      alt: json['alt'] as String? ?? '',
    );
  }

  // Convert map to ProductImage object
  factory ProductImage.fromMap(Map<String, dynamic> map) {
    return ProductImage(
      id: map['id'] ?? 0,
      dateCreated: map['date_created'] ?? '',
      dateModified: map['date_modified'] ?? '',
      src: map['src'] ?? '',
      name: map['name'] ?? '',
      alt: map['alt'] ?? '',
    );
  }
}
