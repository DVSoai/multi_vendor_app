import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';
import 'package:multi_vendor_app/data/repositories/restaurant/restaurant_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodPageBloc extends Bloc<FoodPageEvent, FoodPageState> {
  final RestaurantRepositoryRemote _restaurantRepositoryRemote;
  FoodPageBloc(this._restaurantRepositoryRemote) : super(const FoodPageState(currentPage: 0,count: 1)){
    on<ChangeCurrentPage>(_onChangeCurrentPage);

    on<FetchRestaurantList>(_onFetchRestaurantList);

    on<IncrementCountEvent>(_onIncrementCountEvent);
    on<DecrementCountEvent>(_onDecrementCountEvent);
  }

  void _onChangeCurrentPage(ChangeCurrentPage event, Emitter<FoodPageState> emit) {
    debugPrint('CurrentPage: ${event.currentPage}');
    emit(state.copyWith(currentPage: event.currentPage));
  }

  Future<void>_onFetchRestaurantList(FetchRestaurantList event, Emitter<FoodPageState> emit) async {
    try {
      final restaurant = await _restaurantRepositoryRemote.getRestaurant(code: event.code);
      emit(state.copyWith(restaurant: restaurant));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onIncrementCountEvent(IncrementCountEvent event, Emitter<FoodPageState> emit) {
    emit(state.copyWith(count: state.count! + event.count));
  }
  void _onDecrementCountEvent(DecrementCountEvent event, Emitter<FoodPageState> emit) {

    if(state.count! <= 1){
      return;
    }else{
      emit(state.copyWith(count: state.count! - event.count));
      // emit(state.copyWith(count: (state.count! - event.count).clamp(1, double.infinity).toInt()));

    }
  }
}