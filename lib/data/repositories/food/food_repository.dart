import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';

import '../../../core/network/source/api.dart';
import '../../../core/network/source/api_type.dart';

class ApiFood {
  static const String fetFood = '/api/foods/recommendation/';
  static const String fetAllFood = '/api/foods/byCode';
  static const String fetFoodByCategory = '/api/foods';
  static const String getFoodById = '/api/foods/restaurant-foods/';
  static const String getFoodByCode = '/api/foods/recommendation/';
}

class FoodRepositoryRemote {
  final ApiClient _apiClient;

  FoodRepositoryRemote(this._apiClient);

  Future<List<FoodsModel>> getFood(
      {Map<String, dynamic>? queryParam, required String code}) async {
    try {
      final response = await _apiClient.request(
          path: '${ApiFood.fetFood}/$code',
          method: ApiType.get,
          queryParameters: queryParam);
      debugPrint('path: ${ApiFood.fetFood}$code');
      return List.of(response).map((e) => FoodsModel.fromJson(e)).toList();
    } catch (e) {
      print('e: $e');
      rethrow;
    }
  }

  Future<List<FoodsModel>> getAllFood(
      {Map<String, dynamic>? queryParam, required String code}) async {
    try {
      final response = await _apiClient.request(
          path: '${ApiFood.fetAllFood}/$code',
          method: ApiType.get,
          queryParameters: queryParam);
      return List.of(response).map((e) => FoodsModel.fromJson(e)).toList();
    } catch (e) {
      print('e: $e');
      rethrow;
    }
  }

  Future<List<FoodsModel>> getFoodByCategory(
      {Map<String, dynamic>? queryParam,
      required String code,
      required String category}) async {
    try {
      final response = await _apiClient.request(
          path: '${ApiFood.fetFoodByCategory}/$category/$code',
          method: ApiType.get,
          queryParameters: queryParam);
      return List.of(response).map((e) => FoodsModel.fromJson(e)).toList();
    } catch (e) {
      print('e: $e');
      rethrow;
    }
  }

  Future<List<FoodsModel>> getFoodsById(
      {Map<String, dynamic>? queryParam, required String id}) async {
    try {
      final response = await _apiClient.request(
          path: '${ApiFood.getFoodById}$id',
          method: ApiType.get,
          queryParameters: queryParam);
      return List.of(response).map((e) => FoodsModel.fromJson(e)).toList();
    } catch (e) {
      print('e: $e');
      rethrow;
    }
  }

  Future<List<FoodsModel>> getFoodsByCode(
      {Map<String, dynamic>? queryParam, required String code}) async {
    try {
      final response = await _apiClient.request(
          path: '${ApiFood.getFoodByCode}$code',
          method: ApiType.get,
          queryParameters: queryParam);
      return List.of(response).map((e) => FoodsModel.fromJson(e)).toList();
    } catch (e) {
      print('e: $e');
      rethrow;
    }
  }
}
