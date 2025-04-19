part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String category;
  final String title;

  final List<CategoriesModel> listCategory;

  final List<RestaurantModel> listRestaurant;
  final List<FoodsModel> listFoods;
  final List<FoodsModel>? listFoodsCategory;

  final AddressModel? defaultAddress;

  const HomeState({
    required this.category,
    required this.title,
    required this.listCategory,
    required this.isLoading ,
    required this.listRestaurant,
    required this.listFoods,
    required this.listFoodsCategory,
    required this.defaultAddress

});

  factory HomeState.initial() {
    return const HomeState(
      category: '',
      title: '',
      listCategory: [],
      isLoading: false,
      listRestaurant: [],
      listFoods: [],
      listFoodsCategory: [],
      defaultAddress: null,


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
    AddressModel? defaultAddress,

  }) {
    return HomeState(
      category: category ?? this.category,
      title: title ?? this.title,
      listCategory: listCategory ?? this.listCategory,
      isLoading: isLoading ?? this.isLoading,
      listRestaurant: listRestaurant ?? this.listRestaurant,
      listFoods: listFoods ?? this.listFoods,
      listFoodsCategory: listFoodsCategory ?? this.listFoodsCategory,
      defaultAddress: defaultAddress ?? this.defaultAddress,
    );
  }

  @override
  List<Object?> get props => [category, title, listCategory, isLoading, listRestaurant, listFoods, listFoodsCategory, defaultAddress];
}