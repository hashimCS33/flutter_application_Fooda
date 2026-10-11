import 'package:flutter_application_hungray/Features/orderHistory/data/order_model.dart';

class OrdersState {
  final bool isLoading;
  final List<OrderModel> orders;

  /// One-off error message to be shown by the UI.
  final String? message;

  const OrdersState({
    this.isLoading = true,
    this.orders = const [],
    this.message,
  });

  OrdersState copyWith({
    bool? isLoading,
    List<OrderModel>? orders,
    String? message,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
      message: message,
    );
  }
}
