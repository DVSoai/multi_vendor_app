

part of 'food_bloc.dart';

class FoodPageEvent extends Equatable {
  const FoodPageEvent();
  @override
  List<Object> get props => [];
}

class ChangeCurrentPage extends FoodPageEvent {
  final int currentPage;

  const  ChangeCurrentPage({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class FetchRestaurantList extends FoodPageEvent {
 final String code;

 const FetchRestaurantList({required this.code});

  @override
  List<Object> get props => [code];
}

class IncrementCountEvent extends FoodPageEvent {
  final int count;

  const IncrementCountEvent(this.count);

  @override
  List<Object> get props => [count];
}

class DecrementCountEvent extends FoodPageEvent {
  final int count;

  const DecrementCountEvent(this.count);

  @override
  List<Object> get props => [count];
}

class LoadAdditives extends FoodPageEvent {
  final List<Additive> additives;

  const LoadAdditives(this.additives);

  @override
  List<Object> get props => [additives];
}

class ToggleAdditive extends FoodPageEvent {
  final int index;
  final bool isChecked;

  const ToggleAdditive(this.index, this.isChecked);

  @override
  List<Object> get props => [index, isChecked];
}

class GetCartAdditives extends FoodPageEvent {

  const GetCartAdditives();
  @override
  List<Object> get props => [];
}
