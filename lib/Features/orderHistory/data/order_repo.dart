import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Core/Network/api_service.dart';
import 'order_model.dart';

class OrderRepo {
  final ApiService apiService = ApiService();

  ///Get Order History
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await apiService.get('/orders');
      return OrderHistoryResponse.fromJson(response).orders;
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }
}
