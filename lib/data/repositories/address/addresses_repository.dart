import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/core/network/source/api.dart';
import 'package:multi_vendor_app/data/models/address/address_model.dart';
import '../../../core/network/source/api_type.dart';



class ApiAddressConstants {
  static const String getAddressesAll = '/api/address/all';
  static const String defaultAddress = '/api/address/default';
  static const String addAddress = '/api/address';
}

class AddressesRepositoryRemote {
  final ApiClient _apiClient;

  AddressesRepositoryRemote(this._apiClient);

  Future<List<AddressModel>> getAddressesAll() async {
    try {
      final repository = await _apiClient.request(
          path: ApiAddressConstants.getAddressesAll, method: ApiType.get);
      return List.of(repository)
          .map((address) => AddressModel.fromJson(address))
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  Future<AddressModel> defaultAddress() async {
    try {
      final repository = await _apiClient.request(
          path: ApiAddressConstants.defaultAddress, method: ApiType.get);
      return AddressModel.fromJson(repository);
    } catch (e) {
      debugPrint('Error: $e');
      rethrow;
    }
  }

  Future<AddressModel> addAddress(Map<String,dynamic> data)async {
    try{
      final repository = await _apiClient.request(path: ApiAddressConstants.addAddress, method: ApiType.post, data: data);

      return AddressModel.fromJson(repository);

    }catch(e){
      debugPrint('Error: $e');
      rethrow;
    }
  }
}
