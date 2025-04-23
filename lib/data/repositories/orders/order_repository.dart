
import 'package:multi_vendor_app/core/network/source/api_type.dart';

import '../../../core/network/source/api.dart';

class ApiOrderConstants {
  static const String createOrder = "/api/orders";
}

class OrderRepositoryRemote {
  final ApiClient _apiClient;

  OrderRepositoryRemote(this._apiClient);

  Future<dynamic> createOrder(String data) async {
    try {
      final response = await _apiClient.request(
        path: ApiOrderConstants.createOrder,
        method: ApiType.post,
        data: data,
      );
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}