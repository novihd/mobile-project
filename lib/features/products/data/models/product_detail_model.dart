import 'package:equatable/equatable.dart';
import 'package:klontong/features/products/domain/entities/product_detail.dart';

class ProductDetailResponse extends Equatable {
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

  const ProductDetailResponse({
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
    required this.sold,
  });

  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) => ProductDetailResponse(
        id: json["_id"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        sku: json["sku"],
        name: json["name"],
        description: json["description"],
        weight: json["weight"],
        width: json["width"],
        length: json["length"],
        height: json["height"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        rating: json["rating"],
        sold: json["sold"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CategoryId": categoryId,
        "categoryName": categoryName,
        "sku": sku,
        "name": name,
        "description": description,
        "weight": weight,
        "width": width,
        "length": length,
        "height": height,
        "image": image,
        "price": price,
        "stock": stock,
        "rating": rating,
        "sold": sold,
      };

  ProductDetail toEntity() {
    return ProductDetail(
      id: id,
      categoryId: categoryId,
      categoryName: categoryName,
      sku: sku,
      name: name,
      description: description,
      weight: weight,
      width: width,
      length: length,
      height: height,
      image: image,
      price: price,
      stock: stock,
      rating: rating,
      sold: sold,
    );
  }

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