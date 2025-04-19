import 'package:multi_vendor_app/core/network/source/api.dart';
import 'package:multi_vendor_app/core/network/source/api_type.dart';
import 'package:multi_vendor_app/data/models/cart/cart_request_model.dart';
import 'package:multi_vendor_app/data/models/cart/cart_response.dart';

class ApiCartConstants {
  static const String cart = '/api/cart';
  static const String removeCart = '/api/cart/delete';
  static const String getCart = '/api/cart';
}

class CartRepositoryRemote {
  final ApiClient _apiClient;

  CartRepositoryRemote(this._apiClient);

  Future<void> addToCart(CartRequestModel cart) async {
    try {
      await _apiClient.request(
          path: ApiCartConstants.cart, method: ApiType.post, data: cart);
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  Future<void> deleteCart(String productId) async {
    try {
      await _apiClient.request(
          path:'${ApiCartConstants.removeCart}/$productId',
          method: ApiType.delete,

      );
    } catch (e) {
      throw Exception('Failed to delete cart: $e');
    }
  }

  Future<List<CartResponseModel>> getCart() async {
    try {
      final response = await _apiClient.request(
          path: ApiCartConstants.getCart, method: ApiType.get);

      return List.of(response)
          .map((cart) => CartResponseModel.fromJson(cart))
          .toList();
    } catch (e) {
      throw Exception('Failed to get cart: $e');
    }
  }
}
