import 'dart:convert';
import '../../domain/entities/photo.dart';

class PhotoModel extends PhotoEntity {
  PhotoModel({
    required super.albumId,
    required super.id,
    required super.title,
    required super.url,
    required super.thumbnailUrl,
  });

  factory PhotoModel.fromMap(Map<String, dynamic> json) => PhotoModel(
    albumId: json["albumId"] as int,
    id: json["id"] as int,
    title: json["title"] as String,
    url: json["url"] as String,
    thumbnailUrl: json["thumbnailUrl"] as String,
  );

  factory PhotoModel.fromJson(String str) => PhotoModel.fromMap(json.decode(str));

  Map<String, dynamic> toMap() => {
    "albumId": albumId,
    "id": id,
    "title": title,
    "url": url,
    "thumbnailUrl": thumbnailUrl,
  };

  String toJson() => json.encode(toMap());
}