

import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/models/auth/user_model.dart';

class GlobalStorageKey {
  const GlobalStorageKey._();

  static const globalStorage = 'globalStorage';
  static const userToken = 'userToken';
  static const userId = '_id';
  static const user = 'user';
  static const isLoggedIn = 'is_logged_in';
  static const verification = 'verification';
  static const phoneVerification = 'phoneVerification';
}

abstract class GlobalStorage {
  Future<void> init();
  UserModel? get user;
  Future<void> saveUser(UserModel user);
  Future<void> clearUser();
  Future<void> saveToken(String token);
  Future<void> saveVerification(bool verification);
  Future<void> savePhoneVerification(bool phoneVerification);
  Future<void> saveIsLoggedIn(bool isLoggedIn);



  // New authentication methods
  String? get userToken;
  String? get userId;
  bool get isLoggedIn;
  bool get verification;
  bool get phoneVerification;





  // Future<void> updateAuthenticationState({
  //   required String? token,
  //   required String? userId,
  // });
  //
  // Future<void> clearAuthenticationState();
}

class GlobalStorageImpl implements GlobalStorage {
  late Box _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox('globalStorage');
  }


  @override
  String? get userToken {
    return _box.get(GlobalStorageKey.userToken);
  }

  @override
  String? get userId {
    return _box.get(GlobalStorageKey.userId);
  }


  @override
  Future<void> clearUser() async {
    await Future.wait([
      _box.delete(GlobalStorageKey.user),
      _box.delete(GlobalStorageKey.isLoggedIn),
      _box.delete(GlobalStorageKey.userToken),
      _box.delete(GlobalStorageKey.verification),
      _box.delete(GlobalStorageKey.phoneVerification),
    ]);
  }
  @override
  bool get isLoggedIn {
    return _box.get(GlobalStorageKey.isLoggedIn, defaultValue: false);
  }
  @override
  bool get verification {
    return _box.get(GlobalStorageKey.verification, defaultValue: false);
  }
  @override
  bool get phoneVerification {
    return _box.get(GlobalStorageKey.phoneVerification, defaultValue: false);
  }



  @override
  UserModel? get user {
    final json = _box.get(GlobalStorageKey.user);
    return json != null ? UserModel.fromJson(json) : null;
  }
  @override
  Future<void> saveToken(String token) async {
    await _box.put(GlobalStorageKey.userToken, token);
  }

  @override
  Future<void>saveVerification(bool verification) async {
    await _box.put(GlobalStorageKey.verification, verification);
  }

  @override
  Future<void> savePhoneVerification(bool phoneVerification) async {
    await _box.put(GlobalStorageKey.phoneVerification, phoneVerification);
  }



  @override
  Future<void> saveUser(UserModel user)async {
    await _box.put(GlobalStorageKey.user, user.toJson());
  }

  @override
  Future<void> saveIsLoggedIn(bool isLoggedIn) {
    return _box.put(GlobalStorageKey.isLoggedIn, isLoggedIn);
  }

}
