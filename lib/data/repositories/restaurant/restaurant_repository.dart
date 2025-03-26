

import 'package:multi_vendor_app/core/network/source/api_type.dart';
import 'package:multi_vendor_app/data/models/hook_models/api_error.dart';

import '../../../core/network/source/api.dart';
import '../../models/hook_models/restaurant_model.dart';

class ApiRestaurantPage {
  static const String getRestaurant = '/api/restaurant/byId';
  static const String getAllRestaurant = '/api/restaurant/all';

}

class RestaurantRepositoryRemote {
  final ApiClient _apiClient;
  RestaurantRepositoryRemote(this._apiClient);

  Future<RestaurantModel> getRestaurant({Map<String, dynamic>? queryParam, required String code} ) async {
    try {
      final response = await _apiClient.request(path: '${ApiRestaurantPage.getRestaurant}/$code', method: ApiType.get, queryParameters: queryParam);
      return RestaurantModel.fromJson(response);
    }catch(e){
      print('e: $e');
      rethrow;
    }

  }
}