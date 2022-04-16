import 'package:fruity/models/order/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_response.g.dart';

@JsonSerializable()
class CreateOrderResponse {
  CreateOrderResponse({
    Order? order,
    String? message,
  }) {
    _order = order;
    _errorMessage = message;
  }

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOrderResponseToJson(this);

  factory CreateOrderResponse.withError(String message) =>
      CreateOrderResponse(message: message);

  Order? _order;
  Order? get order => _order;

  String? _errorMessage;

  @JsonKey(name: 'message')
  String? get errorMessage => _errorMessage;
}
