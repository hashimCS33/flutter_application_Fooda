import 'package:flutter_application_hungray/Features/home/data/repo/product_repo.dart';
import 'package:flutter_application_hungray/Features/product/cubit/product_details_states.dart';
import 'package:flutter_application_hungray/Features/product/data/cart_model.dart';
import 'package:flutter_application_hungray/Features/product/data/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit({required this.productId})
    : super(const ProductDetailsState());

  final int productId;
  final ProductRepo productRepo = ProductRepo();

  Future<void> load() async {
    final toppings = await productRepo.getToppings();
    final sideOptions = await productRepo.getOptions();
    if (isClosed) return;
    emit(state.copyWith(toppings: toppings, sideOptions: sideOptions));
  }

  void setSpicy(double value) => emit(state.copyWith(spicy: value));

  void toggleTopping(int id) {
    emit(state.copyWith(selectedToppings: _toggle(state.selectedToppings, id)));
  }

  void toggleSideOption(int id) {
    emit(
      state.copyWith(
        selectedSideOptions: _toggle(state.selectedSideOptions, id),
      ),
    );
  }

  Future<void> addToCart() async {
    emit(state.copyWith(isAdding: true));
    try {
      final cartItem = CartModel(
        productid: productId,
        quantity: 1,
        spicy: state.spicy,
        toppings: state.selectedToppings,
        sideOptions: state.selectedSideOptions,
      );
      await CartRepo.addToCart(CartRequestModel(items: [cartItem]));
      if (isClosed) return;
      emit(
        state.copyWith(isAdding: false, message: 'Added to cart Successfully'),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(isAdding: false, message: 'Failed to add to cart: $e'),
      );
    }
  }

  List<int> _toggle(List<int> list, int id) {
    return list.contains(id)
        ? list.where((e) => e != id).toList()
        : [...list, id];
  }
}
