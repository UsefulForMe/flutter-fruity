import 'package:fruity/models/cart/cart.dart';
import 'package:fruity/models/seller/seller.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable(explicitToJson: true)
class Product {
  Product(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.imageUrl,
      required this.categoryId,
      required this.imageUrls,
      required this.sellerId,
      required this.seller,
      this.oldPrice,
      this.instruction,
      required this.packs,
      this.origin,
      required this.tags,
      this.unit,
      required this.percent});
  String id;
  String name;
  String description;
  double price;

  @JsonKey(name: 'old_price')
  double? oldPrice;
  @JsonKey(name: 'category_id')
  String categoryId;

  @JsonKey(name: 'seller_id')
  String sellerId;

  @JsonKey(name: 'image_url')
  String imageUrl;
  @JsonKey(defaultValue: 0)
  double percent;
  @JsonKey(name: 'image_urls')
  List<String> imageUrls;

  String? unit;
  List<String> tags;
  String? instruction;
  String? origin;

  Seller seller;

  @JsonKey(name: 'packs', defaultValue: [])
  List<String> packs;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  CartItem toCartItem({int quantity = 1}) {
    return CartItem(
      id: id,
      productId: id,
      name: name,
      price: price,
      unit: unit,
      imageUrl: imageUrl,
      quantity: quantity,
      sellerId: sellerId,
    );
  }
}
