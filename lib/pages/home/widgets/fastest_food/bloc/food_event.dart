part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}


class GetAllFoods extends FoodEvent {
  const GetAllFoods();
}