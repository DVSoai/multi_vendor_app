import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/data/models/additive_check_model.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/data/models/hook_models/restaurant_model.dart';
import 'package:multi_vendor_app/data/repositories/restaurant/restaurant_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodPageBloc extends Bloc<FoodPageEvent, FoodPageState> {
  final RestaurantRepositoryRemote _restaurantRepositoryRemote;
  FoodPageBloc(this._restaurantRepositoryRemote) : super( FoodPageState(currentPage: 0,count: 1,additivesList: const [],initialCheckValue: false,totalPrice: 0.0,additiveTitle: [])){
    on<ChangeCurrentPage>(_onChangeCurrentPage);

    on<FetchRestaurantList>(_onFetchRestaurantList);

    on<IncrementCountEvent>(_onIncrementCountEvent);
    on<DecrementCountEvent>(_onDecrementCountEvent);
    on<LoadAdditives>(_onLoadAdditives);
    on<ToggleAdditive>(_onToggleAdditive);

    // on<GetCartAdditives>(_onGetCartAdditives);

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

  Future<void> _onLoadAdditives(LoadAdditives event, Emitter<FoodPageState> emit) async {
    List<AdditiveCheckModel> updatedAdditives = event.additives
        .map((additive) => AdditiveCheckModel.fromAdditive(additive, checked: state.initialCheckValue ?? false))
        .toList();
    emit(state.copyWith(additivesList: updatedAdditives));
    print('Additives: ${state.additivesList!.length}');
  }

  void _onToggleAdditive(ToggleAdditive event, Emitter<FoodPageState> emit) {
    List<String> ads = [];
    double total = 0;
    final updatedAdditives = List<AdditiveCheckModel>.from(state.additivesList!);

    updatedAdditives[event.index] = updatedAdditives[event.index].copyWith(
      isChecked: event.isChecked,
    );

    // Lây ra danh sách các phụ gia đã được chọn
    for(var additive in updatedAdditives){
      if(additive.isChecked && !ads.contains(additive.title)){
        ads.add(additive.title);
      }else if(!additive.isChecked && ads.contains(additive.title)){
        ads.remove(additive.title);
      }
    }

    // Tính tổng giá của các phụ gia đã chọn
    for(var additive in updatedAdditives){
      if(additive.isChecked){
        total += double.parse(additive.price) ;
      }
    }


    emit(state.copyWith(additivesList: updatedAdditives,totalPrice: total,additiveTitle: ads)); // Emit state mới
  }





}