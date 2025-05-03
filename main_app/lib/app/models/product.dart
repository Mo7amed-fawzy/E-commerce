import 'dart:convert';

import 'package:e_commerce_app/app/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double qty;
  final String category;
  final List<String> images;
  String? id;
  String? userId;
  final List<Rating>? rating;
  double? selQty;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.qty,
    required this.category,
    required this.images,
    this.id,
    this.userId,
    this.rating,
  });

  factory Product.getNewEmpty() {
    return Product(
      name: '',
      description: '',
      price: 0.00,
      qty: 0.00,
      category: '',
      images: [],
      id: '',
      userId: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "qty": qty,
      "category": category,
      "images": images,
      "id": id,
      "userId": userId,
      "rating": rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toDouble() ?? 0.00,
      qty: json['qty']?.toDouble() ?? 0.00,
      category: json['category'] ?? '',

      images:
          json['images'] != null && json['images'] is List
              ? List<String>.from(json['images'])
              : [
                'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=',
              ],

      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      rating:
          json['rating'] != null
              ? List<Rating>.from(json['rating']?.map((x) => Rating.fromMap(x)))
              : null,
    );
  }
  String get firstImage {
    return images.isNotEmpty
        ? images[0]
        : 'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
