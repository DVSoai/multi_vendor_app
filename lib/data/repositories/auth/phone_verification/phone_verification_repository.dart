import 'package:multi_vendor_app/data/models/auth/user_model.dart';

import '../../../../core/network/source/api.dart';
import '../../../../core/network/source/api_type.dart';

class ApiConstantsPhoneVerification {
  static const String phoneVerification = '/api/users/verify_phone';
}

class PhoneVerificationRepositoryRemote {
  final ApiClient _apiClient;
  PhoneVerificationRepositoryRemote(this._apiClient);

  Future<UserModel>verificationPhone(String code) async {
    try{
      final repository  = await _apiClient.request(
        path: '${ApiConstantsPhoneVerification.phoneVerification}/$code' ,
        method: ApiType.get,

      );
      return UserModel.fromJson(repository);

    }catch(e){
      print('Error: $e');
      rethrow;
    }
  }
}