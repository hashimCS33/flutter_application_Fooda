import 'package:flutter_application_hungray/Features/cart/cubit/cart_states.dart';
import 'package:flutter_application_hungray/Features/product/data/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  final CartRepo cartRepo = CartRepo();

  Future<void> fetchCart() async {
    try {
      final response = await cartRepo.getCartData();
      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          cart: response,
          quantities:
              response.cartData.items.map((item) => item.quantity).toList(),
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          message: 'Failed to fetch cart data: $e',
        ),
      );
    }
  }

  Future<void> removeItem(int itemId) async {
    try {
      await cartRepo.removeFromCart(itemId.toString());
      await fetchCart();
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(message: 'Failed to remove item from cart: $e'));
    }
  }

  void increment(int index) {
    final quantities = [...state.quantities];
    quantities[index] += 1;
    emit(state.copyWith(quantities: quantities));
  }

  void decrement(int index) {
    if (state.quantities[index] == 1) return;
    final quantities = [...state.quantities];
    quantities[index] -= 1;
    emit(state.copyWith(quantities: quantities));
  }
}
