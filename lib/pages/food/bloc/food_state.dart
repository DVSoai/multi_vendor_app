part of 'food_bloc.dart';


class FoodPageState extends Equatable{
  final int? currentPage;
  final bool? isLoading;
  final String? errorMessage;
  final RestaurantModel? restaurant;
  final int? count;

  const FoodPageState({
    this.currentPage,
    this.isLoading,
    this.errorMessage,
    this.restaurant,
    this.count,
  });

  FoodPageState copyWith({
    int? currentPage,
    bool? isLoading,
    String? errorMessage,
    RestaurantModel? restaurant,
    int? count,
  }) {
    return FoodPageState(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurant: restaurant ?? this.restaurant,
      count: count ?? this.count,
    );
  }

  @override
  List<Object?> get props => [currentPage, isLoading, errorMessage, restaurant, count];

}