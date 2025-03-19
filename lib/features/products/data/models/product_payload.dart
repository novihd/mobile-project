import 'package:equatable/equatable.dart';

class ProductPayload extends Equatable {
  const ProductPayload({
    required this.categoryId,
    required this.categoryName,
    required this.sku,
    required this.name,
    required this.description,
    required this.weight,
    required this.width,
    required this.length,
    required this.height,
    required this.image,
    required this.price,
    required this.stock,
    required this.rating,
    required this.sold,
  });

  final int categoryId;
  final String categoryName;
  final String sku;
  final String name;
  final String description;
  final int weight;
  final int width;
  final int length;
  final int height;
  final String image;
  final int price;
  final int stock;
  final double rating;
  final int sold;

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryName': categoryName,
      'sku': sku,
      'name': name,
      'description': description,
      'weight': weight,
      'width': width,
      'length': length,
      'height': height,
      'image': image,
      'price': price,
      'stock': stock,
      'rating': rating,
      'sold': sold,
    };
  }

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
        sku,
        name,
        description,
        weight,
        width,
        length,
        height,
        image,
        price,
        stock,
        rating,
        sold,
      ];
}
