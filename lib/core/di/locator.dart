import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:multi_vendor_app/data/repositories/categories/category_repository.dart';
import 'package:multi_vendor_app/data/repositories/search/search_repository.dart';

import '../../data/repositories/food/food_repository.dart';
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
  }
}
