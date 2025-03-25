import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:photo_gallery/domain/entities/product.dart';

class ProductModel extends ProductEntity with EquatableMixin {
  ProductModel({
    required super.id,
    required super.title,
    required super.images,
    required super.thumbnailUrl,
  });

  static List<ProductModel> products(Map<String, dynamic> json) =>
      List<ProductModel>.from(
        json["products"].map((x) => ProductModel.fromMap(x)),
      );

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    images: List<String>.from(json["images"].map((x) => x)),
    thumbnailUrl: json["thumbnail"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "images": List<dynamic>.from(images.map((x) => x)),
    "thumbnail": thumbnailUrl,
  };

  @override
  List<Object> get props => [id, title, images, thumbnailUrl];
}
