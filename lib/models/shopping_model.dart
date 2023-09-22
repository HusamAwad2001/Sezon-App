import 'product_model.dart';

class ShoppingModel {
  String? id;
  final String userId;
  final String address;
  final String paymentMethod;
  final String productDescription;
  final bool isAgree;
  final ProductModel product;

  ShoppingModel({
    this.id,
    required this.userId,
    required this.address,
    required this.paymentMethod,
    required this.productDescription,
    required this.isAgree,
    required this.product,
  });

  factory ShoppingModel.fromJson(Map<String, dynamic> json) {
    return ShoppingModel(
      id: json["id"],
      userId: json["userId"],
      address: json["address"],
      paymentMethod: json["paymentMethod"],
      productDescription: json["productDescription"],
      isAgree: json["isAgree"],
      product: ProductModel.fromJson(json["product"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? '',
      "userId": userId,
      "address": address,
      "paymentMethod": paymentMethod,
      "productDescription": productDescription,
      "isAgree": isAgree,
      "product": product.toJson(),
    };
  }
}
