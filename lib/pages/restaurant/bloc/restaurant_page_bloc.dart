import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';

import '../../../data/repositories/food/food_repository.dart';

part 'restaurant_page_event.dart';
part 'restaurant_page_state.dart';

class RestaurantPageBloc extends Bloc<RestaurantPageEvent,RestaurantPageState>{
  final FoodRepositoryRemote _foodRepositoryRemote ;
  RestaurantPageBloc(this._foodRepositoryRemote) : super(const RestaurantPageState(count: 1, food: [],foodExplore: [])){
    on<FetFoodByIdRestaurantPageEvent>(_onFetFoodByIdRestaurantPageEvent);
    on<FetFoodExploreByCodeRestaurantPageEvent>(_onFetFoodExploreByCodeRestaurantPageEvent);
  }

  Future<void>_onFetFoodByIdRestaurantPageEvent(FetFoodByIdRestaurantPageEvent event, Emitter<RestaurantPageState> emit) async {
    try{
      emit(state.copyWith(isLoading: true));
      final List<FoodsModel> foods = await _foodRepositoryRemote.getFoodsById( id: event.id);
      emit(state.copyWith(food: foods, isLoading: false));

    }
    catch(e){
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void>_onFetFoodExploreByCodeRestaurantPageEvent(FetFoodExploreByCodeRestaurantPageEvent event, Emitter<RestaurantPageState> emit) async {
    try{
      emit(state.copyWith(isLoading: true));
      final List<FoodsModel> foods = await _foodRepositoryRemote.getFoodsByCode( code: event.code);
      emit(state.copyWith(foodExplore: foods, isLoading: false));

    }
    catch(e){
      emit(state.copyWith(error: e.toString()));
    }
  }



}