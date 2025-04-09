
import 'package:multi_vendor_app/data/models/auth/login_model.dart';
import 'package:multi_vendor_app/data/models/auth/register_model.dart';
import 'package:multi_vendor_app/data/models/auth/user_model.dart';

import '../../../../core/network/source/api.dart';
import '../../../../core/network/source/api_type.dart';

class ApiConstantsRegister {
  static const String register = '/api/auth/register';
}

class RegisterRepositoryRemote {
  final ApiClient _apiClient;
  RegisterRepositoryRemote(this._apiClient);


  Future<UserModel> register(RegisterModel register)async{
    try{
      final repository  = await _apiClient.request(
          path: ApiConstantsRegister.register ,
          method: ApiType.post,
          data: register.toJson()
      );
      return UserModel.fromJson(repository);

    }catch(e){
      print('Error: $e');
      rethrow;
    }
  }

}