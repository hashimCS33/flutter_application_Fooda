import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Core/Network/api_service.dart';
import 'cart_model.dart';

class CartRepo {
  static ApiService apiService = ApiService();

  ///Add to Cart
  static Future<void> addToCart(CartRequestModel cartRequest) async {
    try {
      await apiService.post('/cart/add', cartRequest.toJson());
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }

  ///Get Cart

  Future<GetCartResponse> getCartData() async {
    try {
      final response = await apiService.get('/cart');
      return GetCartResponse.fromJson(response);
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }

  ///Remove from Cart
  Future<void> removeFromCart(String productId) async {
    try {
      final response = await apiService.delete(
        '/cart/remove/$productId',
        {},
        {},
      );
      // Backend returns {'status': bool, 'message': ..., 'data': ...} not 'success'.
      if (response['status'] == true) {
        return;
      } else {
        throw ApiErorr(
          message:
              response['message']?.toString() ??
              'Failed to remove product from cart',
        );
      }
    } catch (e) {
      throw ApiErorr(message: e.toString());
    }
  }
}
