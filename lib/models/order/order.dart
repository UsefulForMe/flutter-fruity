import 'package:flutter/material.dart';
import 'package:fruity/constants/app_color.dart';
import 'package:fruity/models/cart/cart.dart';
import 'package:fruity/models/payment/payment.dart';
import 'package:fruity/models/product/product.dart';
import 'package:fruity/models/seller/seller.dart';
import 'package:fruity/models/user_address/user_address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(explicitToJson: true)
class Order {
  Order(
      {required this.id,
      required this.textId,
      required this.seller,
      required this.createdAt,
      required this.updatedAt,
      required this.status,
      required this.payment,
      required this.orderItems,
      required this.paymentId,
      required this.receivedAt,
      required this.sellerId,
      required this.tracks,
      required this.userAddress,
      required this.userAddressId,
      required this.userId,
      this.note,
      this.totalPrice});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);

  String get statusText {
    switch (status) {
      case 'processing':
        return 'Đang xử lý';
      case 'shipping':
        return 'Đang giao';
      case 'delivered':
        return 'Đã giao';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }

  Color get statusColor {
    switch (status) {
      case 'processing':
        return AppColors.palette.shade500;
      case 'shipping':
        return Colors.orange;
      case 'delivered':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get statusColorOverlay {
    switch (status) {
      case 'processing':
        return AppColors.palette.shade200;
      case 'shipping':
        return Colors.orange.shade200;
      case 'delivered':
        return Colors.blue.shade200;
      case 'cancelled':
        return Colors.red.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  String id;

  @JsonKey(name: 'text_id')
  String textId;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @JsonKey(name: 'user_id')
  String userId;

  String status;

  @JsonKey(name: 'seller_id')
  String sellerId;

  Seller seller;

  @JsonKey(name: 'order_items')
  List<OrderItem> orderItems;

  @JsonKey(name: 'payment_id')
  String paymentId;

  @JsonKey(name: 'payment')
  Payment payment;

  List<Track> tracks;

  @JsonKey(name: 'received_at')
  DateTime receivedAt;

  @JsonKey(name: 'user_address_id')
  String userAddressId;

  @JsonKey(name: 'user_address')
  UserAddress userAddress;

  String? note;

  @JsonKey(name: 'total_price')
  double? totalPrice;

  @JsonKey(name: 'shipping_fee', defaultValue: 0)
  double shippingFee = 0;

  @JsonKey(name: 'shipping_distance', defaultValue: 0)
  double shippingDistance = 0;

  double get totalPriceWithShippingFee {
    return totalPrice ?? 0 + shippingFee;
  }
}

@JsonSerializable(explicitToJson: true)
class OrderItem {
  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.productId,
    this.note,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'product_id')
  String productId;

  Product product;

  int quantity;
  double price;
  String? note;

  CartItem toCartItem() {
    return CartItem(
      id: id,
      imageUrl: product.imageUrl,
      name: product.name,
      productId: productId,
      sellerId: product.sellerId,
      unit: product.unit,
      quantity: quantity,
      price: price,
    );
  }
}

@JsonSerializable()
class Track {
  Track(
      {required this.id,
      required this.createdAt,
      required this.status,
      required this.orderId,
      required this.time,
      this.note});

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @JsonKey(name: 'order_id')
  String orderId;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'time')
  DateTime time;

  @JsonKey(name: 'note')
  String? note;

  Color get statusColor {
    switch (status) {
      case 'processing':
        return AppColors.palette.shade500;
      case 'shipping':
        return Colors.orange;
      case 'delivered':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color get statusColorOverlay {
    switch (status) {
      case 'processing':
        return AppColors.palette.shade200;
      case 'shipping':
        return Colors.orange.shade200;
      case 'delivered':
        return Colors.blue.shade200;
      case 'cancelled':
        return Colors.red.shade200;
      default:
        return Colors.grey.shade200;
    }
  }

  String get statusText {
    switch (status) {
      case 'processing':
        return 'Đang xử lý';
      case 'shipping':
        return 'Đang giao';
      case 'delivered':
        return 'Đã giao';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return 'Không xác định';
    }
  }
}
