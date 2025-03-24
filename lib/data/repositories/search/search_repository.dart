
import 'package:multi_vendor_app/core/network/source/api.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';

import '../../../core/network/source/api_type.dart';

class SearchApi {
  static const String search = '/api/foods/search/';

}
class SearchRepositoryRemote {
  final ApiClient _apiClient;
  SearchRepositoryRemote(this._apiClient);

  Future<List<FoodsModel>> searchFoods({Map<String, dynamic>? queryParam, required String query}) async {
    try {
      final response = await _apiClient.request(path: '${SearchApi.search}$query', method: ApiType.get, queryParameters: queryParam);
      return List.of(response).map((e) => FoodsModel.fromJson(e)).toList();
    }catch(e){
      print('e: $e');
      rethrow;
    }
  }

}