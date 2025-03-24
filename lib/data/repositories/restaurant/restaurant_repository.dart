//
//
// import 'package:multi_vendor_app/core/network/source/api_type.dart';
// import 'package:multi_vendor_app/data/models/hook_models/api_error.dart';
//
// import '../../../core/network/source/api.dart';
//
// class ApiRestaurant {
//   static const String getRestaurant = '/api/restaurant';
//   static const String getAllRestaurant = '/api/restaurant/all';
//
// }
//
// class RestaurantRepositoryRemote {
//   final ApiClient _apiClient;
//   RestaurantRepositoryRemote(this._apiClient);
//
//   Future<List<RestaurantModel>> getRestaurant({Map<String, dynamic>? queryParam, required String code} ) async {
//     try {
//       final response = await _apiClient.request(path: '${ApiRestaurant.getRestaurant}/$code', method: ApiType.get, queryParameters: queryParam);
//       return List.of(response).map((e) => RestaurantModel.fromJson(e)).toList();
//     }catch(e){
//       print('e: $e');
//       rethrow;
//     }
//
//   }
//
//   Future<List<RestaurantModel>> getAllRestaurant({Map<String, dynamic>? queryParam, required String code} ) async {
//     try {
//       final response = await _apiClient.request(path: '${ApiRestaurant.getAllRestaurant}/$code', method: ApiType.get, queryParameters: queryParam);
//       return List.of(response).map((e) => RestaurantModel.fromJson(e)).toList();
//     }catch(e){
//       print('e: $e');
//       rethrow;
//     }
//
//   }
// }