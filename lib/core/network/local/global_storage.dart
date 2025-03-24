
import 'package:hive_flutter/hive_flutter.dart';

class GlobalStorageKey {
  const GlobalStorageKey._();

  static const globalStorage = 'globalStorage';
  static const accessToken = 'access_token';
  static const userId = 'user_id';
  static const isLoggedIn = 'is_logged_in';
}

abstract class GlobalStorage {
  Future<void> init();


  // New authentication methods
  String? get accessToken;
  String? get userId;
  bool get isLoggedIn;




  Future<void> updateAuthenticationState({
    required String? token,
    required String? userId,
  });

  Future<void> clearAuthenticationState();
}

class GlobalStorageImpl implements GlobalStorage {
  late Box _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox('globalStorage');
  }



  @override
  String? get accessToken {
    return _box.get(GlobalStorageKey.accessToken);
  }

  @override
  String? get userId {
    return _box.get(GlobalStorageKey.userId);
  }

  @override
  bool get isLoggedIn {
    return _box.get(GlobalStorageKey.isLoggedIn, defaultValue: false);
  }

  @override
  Future<void> updateAuthenticationState({
    required String? token,
    required String? userId,
  }) async {
    if (token == null || userId == null) {
      await clearAuthenticationState();
      return;
    }
    await Future.wait([
      _box.put(GlobalStorageKey.accessToken, token),
      _box.put(GlobalStorageKey.userId, userId),
      _box.put(GlobalStorageKey.isLoggedIn, true),
    ]);
  }

  @override
  Future<void> clearAuthenticationState() async {
    await Future.wait([
      _box.delete(GlobalStorageKey.accessToken),
      _box.delete(GlobalStorageKey.userId),
      _box.delete(GlobalStorageKey.isLoggedIn),

    ]);
  }

}
