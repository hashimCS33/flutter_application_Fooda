import 'package:flutter_application_hungray/Features/product/data/cart_model.dart';

class CartState {
  final bool isLoading;
  final GetCartResponse? cart;
  final List<int> quantities;

  /// One-off error message to be shown by the UI.
  final String? message;

  const CartState({
    this.isLoading = true,
    this.cart,
    this.quantities = const [],
    this.message,
  });

  CartState copyWith({
    bool? isLoading,
    GetCartResponse? cart,
    List<int>? quantities,
    String? message,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cart: cart ?? this.cart,
      quantities: quantities ?? this.quantities,
      message: message,
    );
  }
}
