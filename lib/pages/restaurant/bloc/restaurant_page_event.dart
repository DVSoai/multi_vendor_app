part of 'restaurant_page_bloc.dart';

class RestaurantPageEvent extends Equatable {
  const RestaurantPageEvent();
  @override
  List<Object> get props => [];
}

class FetFoodByIdRestaurantPageEvent extends RestaurantPageEvent {
  final String id;
  const FetFoodByIdRestaurantPageEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class FetFoodExploreByCodeRestaurantPageEvent extends RestaurantPageEvent {
  final String code;
  const FetFoodExploreByCodeRestaurantPageEvent({required this.code});
  @override
  List<Object> get props => [code];
}

