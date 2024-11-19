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
}