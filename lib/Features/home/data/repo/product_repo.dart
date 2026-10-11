import 'package:flutter_application_hungray/Core/Network/api_service.dart';
import 'package:flutter_application_hungray/Features/home/data/model/product_model.dart';
import 'package:flutter_application_hungray/Features/home/data/model/topping_model.dart';
import 'package:flutter_application_hungray/Features/home/data/model/option_model.dart';

class ProductRepo {
  final ApiService _apiServers = ApiService();

  ///get products

  Future<List<ProductModel>> getproducts({String? name}) async {
    try {
      final response = await _apiServers.get(
        '/products',
        (name != null && name.trim().isNotEmpty) ? {'name': name.trim()} : null,
      );

      return (response['data'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  ///get toppings
  Future<List<ToppingModel>> getToppings() async {
    try {
      final response = await _apiServers.get('/toppings');

      return (response['data'] as List)
          .map((topping) => ToppingModel.fromJson(topping))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  ///get options

  Future<List<OptionModel>> getOptions() async {
    try {
      final response = await _apiServers.get('/side-options');

      return (response['data'] as List)
          .map((option) => OptionModel.fromJson(option))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
