

part of 'food_bloc.dart';

class FoodPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeCurrentPage extends FoodPageEvent {
  final int currentPage;

  ChangeCurrentPage({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class FetchRestaurantList extends FoodPageEvent {
 final String code;

  FetchRestaurantList({required this.code});

  @override
  List<Object> get props => [code];
}

class IncrementCountEvent extends FoodPageEvent {
  final int count;

  IncrementCountEvent(this.count);

  @override
  List<Object> get props => [count];
}

class DecrementCountEvent extends FoodPageEvent {
  final int count;

  DecrementCountEvent(this.count);

  @override
  List<Object> get props => [count];
}