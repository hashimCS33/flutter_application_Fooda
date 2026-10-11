import 'package:flutter_application_hungray/Features/home/data/model/option_model.dart';
import 'package:flutter_application_hungray/Features/home/data/model/topping_model.dart';

class ProductDetailsState {
  final double spicy;
  final List<ToppingModel> toppings;
  final List<OptionModel> sideOptions;
  final List<int> selectedToppings;
  final List<int> selectedSideOptions;
  final bool isAdding;

  /// One-off message (success or error) to be shown by the UI.
  final String? message;

  const ProductDetailsState({
    this.spicy = 0.5,
    this.toppings = const [],
    this.sideOptions = const [],
    this.selectedToppings = const [],
    this.selectedSideOptions = const [],
    this.isAdding = false,
    this.message,
  });

  ProductDetailsState copyWith({
    double? spicy,
    List<ToppingModel>? toppings,
    List<OptionModel>? sideOptions,
    List<int>? selectedToppings,
    List<int>? selectedSideOptions,
    bool? isAdding,
    String? message,
  }) {
    return ProductDetailsState(
      spicy: spicy ?? this.spicy,
      toppings: toppings ?? this.toppings,
      sideOptions: sideOptions ?? this.sideOptions,
      selectedToppings: selectedToppings ?? this.selectedToppings,
      selectedSideOptions: selectedSideOptions ?? this.selectedSideOptions,
      isAdding: isAdding ?? this.isAdding,
      message: message,
    );
  }
}
