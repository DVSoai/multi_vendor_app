
part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class GetNearbyRestaurant extends RestaurantEvent {
  const GetNearbyRestaurant();

  @override
  List<Object> get props => [];
}