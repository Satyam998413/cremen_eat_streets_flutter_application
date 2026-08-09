import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category; // 'bhel', 'puri', 'chaat', 'morning_special'
  final bool isSpicy;
  final bool isMorningSpecial;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.isSpicy,
    required this.isMorningSpecial,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'isSpicy': isSpicy,
      'isMorningSpecial': isMorningSpecial,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      category: map['category'] as String,
      isSpicy: map['isSpicy'] as bool,
      isMorningSpecial: map['isMorningSpecial'] as bool,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
        category,
        isSpicy,
        isMorningSpecial,
      ];
}
