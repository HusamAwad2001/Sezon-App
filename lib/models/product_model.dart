class ProductModel {
  String? id;
  final String name;
  final String description;
  final String price;
  String? imageUrl;
  final String category;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      category: json['category'],
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
      'createdAt': DateTime.now(),
    };
  }
}
