part of 'food_bloc.dart';


class FoodState extends Equatable {

  final String error;
  final bool isLoading;
  final List<FoodsModel> foods;

  const FoodState(
  {
    required this.error,
    required this.isLoading,
    required this.foods,
});

  factory FoodState.initial() {
    return const FoodState(
      error: '',
      isLoading: false,
      foods: [],
    );
  }

  FoodState copyWith({
    String? error,
    bool? isLoading,
    List<FoodsModel>? foods,
  }) {
    return FoodState(
      error: error ?? this.error,
      isLoading: isLoading ?? this.isLoading,
      foods: foods ?? this.foods,
    );
  }

  @override
  List<Object> get props => [foods, isLoading, error];
}