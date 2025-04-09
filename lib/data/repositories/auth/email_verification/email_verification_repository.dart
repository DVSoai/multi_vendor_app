import 'package:multi_vendor_app/data/models/auth/user_model.dart';

import '../../../../core/network/source/api.dart';
import '../../../../core/network/source/api_type.dart';

class ApiConstantsEmailVerification {
  static const String emailVerification = '/api/users/verify';
}

class EmailVerificationRepositoryRemote {
  final ApiClient _apiClient;
  EmailVerificationRepositoryRemote(this._apiClient);

  Future<UserModel>verificationEmail(String code) async {
    try{
      final repository  = await _apiClient.request(
          path: '${ApiConstantsEmailVerification.emailVerification}/$code' ,
          method: ApiType.get,
      );
      return UserModel.fromJson(repository);

    }catch(e){
      print('Error: $e');
      rethrow;
    }
  }
}