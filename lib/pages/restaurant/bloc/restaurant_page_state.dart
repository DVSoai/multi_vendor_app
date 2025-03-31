part of 'restaurant_page_bloc.dart';

class RestaurantPageState extends Equatable {
  final int? count;
  final List<FoodsModel>? food;
  final List<FoodsModel>? foodExplore;
  final String? error;
  final bool isLoading;

  const RestaurantPageState(
      {this.count, this.food, this.error, this.isLoading = false,this.foodExplore,});

  RestaurantPageState copyWith(
      {int? count,
      List<FoodsModel>? food,
      String? error,
      bool? isLoading,
      List<FoodsModel>? foodExplore}) {
    return RestaurantPageState(
        count: count ?? this.count,
        food: food ?? this.food,
        error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        foodExplore: foodExplore ?? this.foodExplore);
  }

  @override
  List<Object?> get props => [count, food, error, isLoading,foodExplore];
}
