import 'dart:convert';

class Product {
  final int id;
  final String name;
  final String slug;
  final String permalink;
  final String dateCreated;
  final String dateCreatedGmt;
  final String dateModified;
  final String dateModifiedGmt;
  final String type;
  final String status;
  final bool featured;
  final String catalogVisibility;
  final String description;
  final String shortDescription;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final bool purchasable;
  final String totalSales;
  final bool virtual;
  final bool downloadable;
  final List<dynamic> downloads;
  final int downloadLimit;
  final int downloadExpiry;
  final String externalUrl;
  final String buttonText;
  final String taxStatus;
  final String taxClass;
  final bool manageStock;
  final int? stockQuantity;
  final String backorders;
  final bool backordersAllowed;
  final bool backordered;
  final int? lowStockAmount;
  final bool soldIndividually;
  final String weight;
  final Map<String, String> dimensions;
  final bool shippingRequired;
  final bool shippingTaxable;
  final String shippingClass;
  final int shippingClassId;
  final bool reviewsAllowed;
  final String averageRating;
  final int ratingCount;
  final List<int> upsellIds;
  final List<int> crossSellIds;
  final int parentId;
  final String purchaseNote;
  final List<Category> categories;
  final List<dynamic> tags;
  final List<ProductImage> images;
  final List<Attribute> attributes;
  final List<dynamic> defaultAttributes;
  final List<dynamic> variations;
  final List<int> relatedIds;
  final int? wishListId; // New property
  final int? quantity;    // New property
  final String? color;    // New property
  final String? size;     // New property
  final Pivot? pivot;     // New property

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.permalink,
    required this.dateCreated,
    required this.dateCreatedGmt,
    required this.dateModified,
    required this.dateModifiedGmt,
    required this.type,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.onSale,
    required this.purchasable,
    required this.totalSales,
    required this.virtual,
    required this.downloadable,
    required this.downloads,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.externalUrl,
    required this.buttonText,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    this.stockQuantity,
    required this.backorders,
    required this.backordersAllowed,
    required this.backordered,
    this.lowStockAmount,
    required this.soldIndividually,
    required this.weight,
    required this.dimensions,
    required this.shippingRequired,
    required this.shippingTaxable,
    required this.shippingClass,
    required this.shippingClassId,
    required this.reviewsAllowed,
    required this.averageRating,
    required this.ratingCount,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.purchaseNote,
    required this.categories,
    required this.tags,
    required this.images,
    required this.attributes,
    required this.defaultAttributes,
    required this.variations,
    required this.relatedIds,
    this.wishListId,    // New property
    this.quantity,       // New property
    this.color,          // New property
    this.size,           // New property
    this.pivot,          // New property
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      permalink: json['permalink'] ?? '',
      dateCreated: json['date_created'] ?? '',
      dateCreatedGmt: json['date_created_gmt'] ?? '',
      dateModified: json['date_modified'] ?? '',
      dateModifiedGmt: json['date_modified_gmt'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      featured: json['featured'] ?? false,
      catalogVisibility: json['catalog_visibility'] ?? '',
      description: json['description'] ?? '',
      shortDescription: json['short_description'] ?? '',
      sku: json['sku'] ?? '',
      price: json['price']?.toString() ?? '0', // Convert int to string if necessary
      regularPrice: json['regular_price']?.toString() ?? '0',
      salePrice: json['sale_price']?.toString() ?? '0',
      onSale: json['on_sale'] ?? false,
      purchasable: json['purchasable'] ?? false,
      totalSales: json['total_sales']?.toString() ?? '0', // Ensure it's a string
      virtual: json['virtual'] ?? false,
      downloadable: json['downloadable'] ?? false,
      downloads: List<dynamic>.from(json['downloads'] ?? []),
      downloadLimit: json['download_limit'] ?? 0,
      downloadExpiry: json['download_expiry'] ?? 0,
      externalUrl: json['external_url'] ?? '',
      buttonText: json['button_text'] ?? '',
      taxStatus: json['tax_status'] ?? '',
      taxClass: json['tax_class'] ?? '',
      manageStock: json['manage_stock'] ?? false,
      stockQuantity: json['stock_quantity'],
      backorders: json['backorders'] ?? '',
      backordersAllowed: json['backorders_allowed'] ?? false,
      backordered: json['backordered'] ?? false,
      lowStockAmount: json['low_stock_amount'],
      soldIndividually: json['sold_individually'] ?? false,
      weight: json['weight']?.toString() ?? '0', // Convert to string if needed
      dimensions: Map<String, String>.from(json['dimensions'] ?? {}),
      shippingRequired: json['shipping_required'] ?? false,
      shippingTaxable: json['shipping_taxable'] ?? false,
      shippingClass: json['shipping_class'] ?? '',
      shippingClassId: json['shipping_class_id'] ?? 0,
      reviewsAllowed: json['reviews_allowed'] ?? false,
      averageRating: json['average_rating']?.toString() ?? '0', // Convert to string if needed
      ratingCount: json['rating_count'] ?? 0,
      upsellIds: List<int>.from(json['upsell_ids'] ?? []),
      crossSellIds: List<int>.from(json['cross_sell_ids'] ?? []),
      parentId: json['parent_id'] ?? 0,
      purchaseNote: json['purchase_note'] ?? '',
      categories: List<Category>.from(json['categories']?.map((e) => Category.fromJson(e)) ?? []),
      tags: List<dynamic>.from(json['tags'] ?? []),
      images: List<ProductImage>.from(json['images']?.map((e) => ProductImage.fromJson(e)) ?? []),
      attributes: List<Attribute>.from(json['attributes']?.map((e) => Attribute.fromJson(e)) ?? []),
      defaultAttributes: List<dynamic>.from(json['default_attributes'] ?? []),
      variations: List<dynamic>.from(json['variations'] ?? []),
      relatedIds: List<int>.from(json['related_ids'] ?? []),
      wishListId: json['wishlist_id'], // New property
      quantity: json['quantity'],        // New property
      color: json['color'],              // New property
      size: json['size'],                // New property
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null, // New property
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;

  Category({required this.id, required this.name, required this.slug});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class ProductImage {
  final int id;
  final String dateCreated;
  final String dateModified;
  final String src;
  final String name;
  final String alt;

  ProductImage({
    required this.id,
    required this.dateCreated,
    required this.dateModified,
    required this.src,
    required this.name,
    required this.alt,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      dateCreated: json['date_created'],
      dateModified: json['date_modified'],
      src: json['src'],
      name: json['name'],
      alt: json['alt'],
    );
  }
}

class Attribute {
  final int id;
  final String name;
  final String slug;
  final bool visible;
  final bool variation;
  final List<String> options;

  Attribute({
    required this.id,
    required this.name,
    required this.slug,
    required this.visible,
    required this.variation,
    required this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      visible: json['visible'],
      variation: json['variation'],
      options: List<String>.from(json['options']),
    );
  }
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