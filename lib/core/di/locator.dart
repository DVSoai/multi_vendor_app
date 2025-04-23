import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_vendor_app/data/repositories/auth/email_verification/email_verification_repository.dart';
import 'package:multi_vendor_app/data/repositories/auth/login/login_repository.dart';
import 'package:multi_vendor_app/data/repositories/auth/register/register_repository.dart';
import 'package:multi_vendor_app/data/repositories/cart/cart_repository.dart';
import 'package:multi_vendor_app/data/repositories/categories/category_repository.dart';
import 'package:multi_vendor_app/data/repositories/restaurant/restaurant_repository.dart';
import 'package:multi_vendor_app/data/repositories/search/search_repository.dart';

import '../../data/repositories/address/addresses_repository.dart';
import '../../data/repositories/auth/phone_verification/phone_verification_repository.dart';
import '../../data/repositories/food/food_repository.dart';
import '../../data/repositories/orders/order_repository.dart';
import '../network/local/global_storage.dart';
import '../network/source/api.dart';

// GetIt is a package used for service locator to manage dependency injection
GetIt sl = GetIt.instance;

class ServiceLocator {
  Future<void> servicesLocator() async {
    final storage = GlobalStorageImpl();

    await storage.init();

    sl.registerSingleton<GlobalStorage>(storage);

    // Dio and API Client
    final dio = Dio();
    sl.registerSingleton<ApiClient>(ApiClient(dio, sl<GlobalStorage>()));
    sl.registerFactory<CategoryRepositoryRemote>(
            () => CategoryRepositoryRemote(sl<ApiClient>()));
    sl.registerFactory<FoodRepositoryRemote>(
            () => FoodRepositoryRemote(sl<ApiClient>()));
    sl.registerFactory<SearchRepositoryRemote>(
            () => SearchRepositoryRemote(sl<ApiClient>())
    );
    sl.registerFactory<LoginRepositoryRemote>(() => LoginRepositoryRemote(sl<ApiClient>()));
    sl.registerFactory<RegisterRepositoryRemote>(() => RegisterRepositoryRemote(sl<ApiClient>()));
    sl.registerFactory<RestaurantRepositoryRemote>(()=> RestaurantRepositoryRemote(sl<ApiClient>()));
    sl.registerFactory<EmailVerificationRepositoryRemote>(() => EmailVerificationRepositoryRemote(sl<ApiClient>()));
    sl.registerFactory<PhoneVerificationRepositoryRemote>(() => PhoneVerificationRepositoryRemote(sl<ApiClient>()));
     sl.registerFactory<AddressesRepositoryRemote>(() => AddressesRepositoryRemote(sl<ApiClient>()));
     sl.registerFactory<CartRepositoryRemote>(() => CartRepositoryRemote(sl<ApiClient>()));
     sl.registerFactory<OrderRepositoryRemote>(() => OrderRepositoryRemote(sl<ApiClient>()));
  }
}
