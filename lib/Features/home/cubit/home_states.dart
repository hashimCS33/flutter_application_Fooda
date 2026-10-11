import 'package:flutter_application_hungray/Features/home/data/model/product_model.dart';

class HomeState {
  final bool isLoading;
  final List<ProductModel> products;
  final int selectedCategory;

  const HomeState({
    this.isLoading = true,
    this.products = const [],
    this.selectedCategory = 0,
  });

  HomeState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
    int? selectedCategory,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
