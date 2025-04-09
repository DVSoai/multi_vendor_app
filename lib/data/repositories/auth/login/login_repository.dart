
import 'package:multi_vendor_app/data/models/auth/login_model.dart';
import 'package:multi_vendor_app/data/models/auth/user_model.dart';

import '../../../../core/network/source/api.dart';
import '../../../../core/network/source/api_type.dart';

class ApiConstantsLogin {
  static const String login = '/api/auth/login';
}

class LoginRepositoryRemote {
  final ApiClient _apiClient;
  LoginRepositoryRemote(this._apiClient);


  Future<UserModel> login(LoginModel login)async{
    try{
      final repository  = await _apiClient.request(
          path: ApiConstantsLogin.login ,
          method: ApiType.post,
        data: login.toJson()
      );
      return UserModel.fromJson(repository);

    }catch(e){
      print('Error: $e');
      rethrow;
    }
  }

}