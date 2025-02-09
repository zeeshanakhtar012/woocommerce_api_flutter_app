import 'dart:convert';

import 'package:zrj/model/category.dart';

import 'model_images.dart';

class Product {
      int? id;
      String? name;
      String? slug;
      String? permalink;
      String? dateCreated;
      String? dateCreatedGmt;
      String? dateModified;
      String? dateModifiedGmt;
      String? type;
      String? status;
      bool? featured;
      String? catalogVisibility;
      String? description;
      String? shortDescription;
      String? sku;
      String? price;
      String? regularPrice;
      String? salePrice;
      bool? onSale;
      bool? purchasable;
      String? totalSales;
      bool? virtual;
      bool? downloadable;
      List<dynamic>? downloads;
      int? downloadLimit;
      int? downloadExpiry;
      String? externalUrl;
      String? buttonText;
      String? taxStatus;
      String? taxClass;
      bool? manageStock;
      int? stockQuantity;
      String? backorders;
      bool? backordersAllowed;
      bool? backordered;
      int? lowStockAmount;
      bool? soldIndividually;
      String? weight;
      Map<String, String>? dimensions;
      bool? shipping;
      bool? shippingTaxable;
      String? shippingClass;
      int? shippingClassId;
      bool? reviewsAllowed;
      String? averageRating;
      int? ratingCount;
      List<int>? upsellIds;
      List<int>? crossSellIds;
      int? parentId;
      String? purchaseNote;
      List<Category>? categories;
      List<dynamic>? tags;
      List<ProductImage>? images;
      List<Attribute>? attributes;
      List<dynamic>? defaultAttributes;
      List<dynamic>? variations;
      List<int>? relatedIds;
      int? wishListId;
      int? quantity;
      String? color;
      String? size;
      Pivot? pivot;

  Product({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.lowStockAmount,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shipping,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.relatedIds,
    this.wishListId,
    this.quantity,
    this.color,
    this.size,
    this.pivot,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      permalink: json['permalink'] as String? ?? '',
      dateCreated: json['date_created'] as String? ?? '',
      dateCreatedGmt: json['date_created_gmt'] as String? ?? '',
      dateModified: json['date_modified'] as String? ?? '',
      dateModifiedGmt: json['date_modified_gmt'] as String? ?? '',
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? '',
      featured: json['featured'] as bool? ?? false,
      catalogVisibility: json['catalog_visibility'] as String? ?? '',
      description: json['description'] as String? ?? '',
      shortDescription: json['short_description'] as String? ?? '',
      sku: json['sku'] as String? ?? '',
      price: json['price']?.toString() ?? '0.0',
      regularPrice: json['regular_price']?.toString() ?? '0.0',
      salePrice: json['sale_price']?.toString() ?? '0.0',
      onSale: json['on_sale'] as bool? ?? false,
      purchasable: json['purchasable'] as bool? ?? false,
      totalSales: json['total_sales']?.toString() ?? '0',
      virtual: json['virtual'] as bool? ?? false,
      downloadable: json['downloadable'] as bool? ?? false,
      downloads: json['downloads'] as List<dynamic>? ?? [],
      downloadLimit: json['download_limit'] as int? ?? 0,
      downloadExpiry: json['download_expiry'] as int? ?? 0,
      externalUrl: json['external_url'] as String? ?? '',
      buttonText: json['button_text'] as String? ?? '',
      taxStatus: json['tax_status'] as String? ?? '',
      taxClass: json['tax_class'] as String? ?? '',
      manageStock: json['manage_stock'] as bool? ?? false,
      stockQuantity: json['stock_quantity'] as int? ?? 0,
      backorders: json['backorders'] as String? ?? '',
      backordersAllowed: json['backorders_allowed'] as bool? ?? false,
      backordered: json['backordered'] as bool? ?? false,
      lowStockAmount: json['low_stock_amount'] as int? ?? 0,
      soldIndividually: json['sold_individually'] as bool? ?? false,
      weight: json['weight']?.toString() ?? '0.0',
      dimensions: json['dimensions'] != null
          ? Map<String, String>.from(json['dimensions'])
          : {},
      shipping: json['shipping'] as bool? ?? false,
      shippingTaxable: json['shipping_taxable'] as bool? ?? false,
      shippingClass: json['shipping_class'] as String? ?? '',
      shippingClassId: json['shipping_class_id'] as int? ?? 0,
      reviewsAllowed: json['reviews_allowed'] as bool? ?? false,
      averageRating: json['average_rating']?.toString() ?? '0.0',
      ratingCount: json['rating_count'] as int? ?? 0,
      upsellIds: json['upsell_ids'] != null
          ? List<int>.from(json['upsell_ids'])
          : [],
      crossSellIds: json['cross_sell_ids'] != null
          ? List<int>.from(json['cross_sell_ids'])
          : [],
      parentId: json['parent_id'] as int? ?? 0,
      purchaseNote: json['purchase_note'] as String? ?? '',
      categories: json['categories'] != null
          ? List<Category>.from(
          json['categories'].map((e) => Category.fromJson(e)))
          : [],
      tags: json['tags'] as List<dynamic>? ?? [],
      images: json['images'] != null
          ? List<ProductImage>.from(
          json['images'].map((e) => ProductImage.fromJson(e)))
          : [],
      attributes: json['attributes'] != null
          ? List<Attribute>.from(
          json['attributes'].map((e) => Attribute.fromJson(e)))
          : [],
      defaultAttributes: json['default_attributes'] as List<dynamic>? ?? [],
      variations: json['variations'] as List<dynamic>? ?? [],
      relatedIds: json['related_ids'] != null
          ? List<int>.from(json['related_ids'])
          : [],
      wishListId: json['wishlist_id'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      color: json['color'] as String? ?? '',
      size: json['size'] as String? ?? '',
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : Pivot(),
    );
  }
}

// Apply similar null handling for ProductImage, Attribute, and Pivot classes

class Attribute {
      int? id;
      String? name;
      int? position;
      bool? visible;
      bool? variation;
      List<String>? options;

  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      position: json['position'] as int? ?? 0,
      visible: json['visible'] as bool? ?? false,
      variation: json['variation'] as bool? ?? false,
      options: json['options'] != null
          ? List<String>.from(json['options'])
          : [],
    );
  }
}

class Pivot {
      int? productId;
      int? attributeId;

  Pivot({
    this.productId,
    this.attributeId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      productId: json['product_id'] as int? ?? 0,
      attributeId: json['attribute_id'] as int? ?? 0,
    );
  }
}
