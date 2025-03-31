part of 'food_bloc.dart';


class FoodPageState extends Equatable{
  final int? currentPage;
  final bool? isLoading;
  final String? errorMessage;
  final RestaurantModel? restaurant;
  final int? count;
  List<AdditiveCheckModel>? additivesList;
  final bool? initialCheckValue;
  final double? totalPrice;
  final List<String>? additiveTitle;

   FoodPageState({
    this.currentPage,
    this.isLoading,
    this.errorMessage,
    this.restaurant,
    this.count,
    this.additivesList,
    this.initialCheckValue,
    this.totalPrice,
    this.additiveTitle,
  });

  FoodPageState copyWith({
    int? currentPage,
    bool? isLoading,
    String? errorMessage,
    RestaurantModel? restaurant,
    int? count,
    List<AdditiveCheckModel>? additivesList,
    bool? initialCheckValue,
    double? totalPrice,
   List<String>? additiveTitle,
  }) {
    return FoodPageState(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurant: restaurant ?? this.restaurant,
      count: count ?? this.count,
      additivesList: additivesList ?? this.additivesList,
      initialCheckValue: initialCheckValue ?? this.initialCheckValue,
      totalPrice: totalPrice ?? this.totalPrice,
      additiveTitle: additiveTitle ?? this.additiveTitle,
    );
  }

  @override
  List<Object?> get props => [currentPage, isLoading, errorMessage, restaurant, count, additivesList, initialCheckValue,totalPrice,additiveTitle];

}