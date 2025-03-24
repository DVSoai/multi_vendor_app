part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String category;
  final String title;

  final List<CategoriesModel> listCategory;

  final List<RestaurantModel> listRestaurant;
  final List<FoodsModel> listFoods;
  final List<FoodsModel>? listFoodsCategory;

  HomeState({
    required this.category,
    required this.title,
    required this.listCategory,
    required this.isLoading ,
    required this.listRestaurant,
    required this.listFoods,
    required this.listFoodsCategory,
});

  factory HomeState.initial() {
    return HomeState(
      category: '',
      title: '',
      listCategory: const [],
      isLoading: false,
      listRestaurant: const [],
      listFoods: const [],
      listFoodsCategory: const [],
    );
  }

  HomeState copyWith({
    String? category,
    String? title,
    List<CategoriesModel>? listCategory,
    bool? isLoading,
    List<RestaurantModel>? listRestaurant,
    List<FoodsModel>? listFoods,
    List<FoodsModel>? listFoodsCategory,
  }) {
    return HomeState(
      category: category ?? this.category,
      title: title ?? this.title,
      listCategory: listCategory ?? this.listCategory,
      isLoading: isLoading ?? this.isLoading,
      listRestaurant: listRestaurant ?? this.listRestaurant,
      listFoods: listFoods ?? this.listFoods,
      listFoodsCategory: listFoodsCategory ?? this.listFoodsCategory,
    );
  }

  @override
  List<Object> get props => [category, title, listCategory, isLoading, listRestaurant, listFoods, listFoodsCategory??[]];
}