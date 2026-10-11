import 'dart:async';

import 'package:flutter_application_hungray/Features/home/cubit/home_states.dart';
import 'package:flutter_application_hungray/Features/home/data/repo/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final ProductRepo productRepo = ProductRepo();
  Timer? _debounce;
  int _requestId = 0;

  Future<void> getProducts({String? name}) async {
    final requestId = ++_requestId;
    emit(state.copyWith(isLoading: true));
    final products = await productRepo.getproducts(name: name);
    // Ignore stale responses (e.g. an older search finishing after a newer one).
    if (isClosed || requestId != _requestId) return;
    emit(state.copyWith(isLoading: false, products: products));
  }

  void onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      getProducts(name: value);
    });
  }

  void selectCategory(int index) {
    emit(state.copyWith(selectedCategory: index));
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
