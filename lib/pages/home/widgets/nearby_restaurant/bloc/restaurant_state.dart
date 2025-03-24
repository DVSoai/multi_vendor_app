
part of 'restaurant_bloc.dart';
 class RestaurantState extends Equatable {
   final bool isLoading;
  final List<RestaurantModel> listAllRestaurant;
  final String error;
 const  RestaurantState({
    required this.isLoading,
    required this.listAllRestaurant,
   required this.error,
});

  factory RestaurantState.initial() {
    return const RestaurantState(
      isLoading: false,
      listAllRestaurant:  [],
      error: '',
    );
  }

  RestaurantState copyWith({
    bool? isLoading,
    List<RestaurantModel>? listAllRestaurant,
    String? error,
  }) {
    return RestaurantState(
      isLoading: isLoading ?? this.isLoading,
      listAllRestaurant: listAllRestaurant ?? this.listAllRestaurant,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [isLoading,listAllRestaurant,error];


}