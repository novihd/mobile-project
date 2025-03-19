import 'package:equatable/equatable.dart';

class ProductDetail extends Equatable {
  const ProductDetail({
    required this.id,
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
    required this.sold    
  });

  final String id;
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

  @override
  List<Object?> get props => [
        id,
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
