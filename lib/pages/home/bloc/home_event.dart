part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UpdateCategories extends HomeEvent {
  const UpdateCategories();
}

class UpdateTitle extends HomeEvent {
  const UpdateTitle();
}

class UpdateCategoryAndTitle extends HomeEvent {
  final String category;
  final String title;

  const UpdateCategoryAndTitle({
    required this.category,
    required this.title,
  });

  @override
  List<Object> get props => [category, title];
}

class GetListCategories extends HomeEvent {
  const GetListCategories();
}
class GetListCategoriesAll extends HomeEvent {
  const GetListCategoriesAll();
}

class GetRestaurant extends HomeEvent {
  final String code;

  const GetRestaurant({
    required this.code,
  });
}

class GetRestaurantAll extends HomeEvent {
  final String code;
  const GetRestaurantAll(
  {
    required this.code,
  });
}
class GetFoods extends HomeEvent {
  final String code;
  const GetFoods(
  {
    required this.code,
  });
}

class GetFoodsAll extends HomeEvent {
  final String code;
  final String category;
  final String title;
  const GetFoodsAll(
  {
    required this.code,
    required this.category,
    required this.title,
  });
}

