import 'package:multi_vendor_app/core/network/source/api_type.dart';
import 'package:multi_vendor_app/data/models/hook_models/category/categories_model.dart';

import '../../../core/network/source/api.dart';
import '../../models/hook_models/restaurant_model.dart';

class ApiConst {
  static const String getCategoryRandom = '/api/category/random';
  static const String getCategoryAll = '/api/category';
  static const String getRestaurant = '/api/restaurant';
  static const String getAllRestaurant = '/api/restaurant/all';
}
class CategoryRepositoryRemote {
  final ApiClient _apiClient;

  CategoryRepositoryRemote(this._apiClient);


  Future<List<CategoriesModel>> fetchData({Map<String, dynamic>? queryParam})async {
    try{
      final response = await _apiClient.request(
        path: ApiConst.getCategoryRandom,
        method: ApiType.get,
        queryParameters: queryParam
      );
      return List.of(response).map((e) => CategoriesModel.fromJson(e)).toList();

    }catch(e){
      print("Error: $e");
      rethrow;
    }
  }
  Future<List<CategoriesModel>> getAllCategory({Map<String, dynamic>? queryParam})async {
    try{
      final response = await _apiClient.request(
          path: ApiConst.getCategoryAll,
          method: ApiType.get,
          queryParameters: queryParam
      );
      return List.of(response).map((e) => CategoriesModel.fromJson(e)).toList();

    }catch(e){
      print("Error: $e");
      rethrow;
    }
  }

  Future<List<RestaurantModel>> getRestaurant({Map<String, dynamic>? queryParam, required String code} ) async {
    try {
      final response = await _apiClient.request(path: '${ApiConst.getRestaurant}/$code', method: ApiType.get, queryParameters: queryParam);
      return List.of(response).map((e) => RestaurantModel.fromJson(e)).toList();
    }catch(e){
      print('e: $e');
      rethrow;
    }

  }

  Future<List<RestaurantModel>> getAllRestaurant({Map<String, dynamic>? queryParam, required String code} ) async {
    try {
      final response = await _apiClient.request(path: '${ApiConst.getAllRestaurant}/$code', method: ApiType.get, queryParameters: queryParam);
      return List.of(response).map((e) => RestaurantModel.fromJson(e)).toList();
    }catch(e){
      print('e: $e');
      rethrow;
    }

  }

}