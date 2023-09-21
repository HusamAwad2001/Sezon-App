import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  final String name;
  final String description;
  final String price;
  String? imageUrl;
  final String category;
  int? purchases;
  Timestamp? createdAt;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category,
    this.purchases,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      purchases: json['purchases'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'purchases': purchases,
      'createdAt': DateTime.now(),
    };
  }
}
