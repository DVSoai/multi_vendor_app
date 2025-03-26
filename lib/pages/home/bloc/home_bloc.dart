import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/data/models/hook_models/api_error.dart';
import 'package:multi_vendor_app/data/models/hook_models/category/categories_model.dart';
import 'package:multi_vendor_app/data/models/hook_models/food_model.dart';
import 'package:multi_vendor_app/data/repositories/food/food_repository.dart';

import '../../../core/network/source/exception.dart';
import '../../../data/models/hook_models/restaurant_model.dart';
import '../../../data/repositories/categories/category_repository.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  final CategoryRepositoryRemote _categoryRepositoryRemote;
  final FoodRepositoryRemote _foodRepositoryRemote;
  HomeBloc(this._categoryRepositoryRemote,this._foodRepositoryRemote) : super(HomeState.initial()){
    on<UpdateCategories>((event, emit) {
      emit(state.copyWith(category: state.category));
    });
    on<UpdateTitle>((event, emit) {
      emit(state.copyWith(title: state.title));
    });
    on<UpdateCategoryAndTitle>((event, emit) {
      emit(state.copyWith(category: event.category, title: event.title));
    });

    // Get list categories
    on<GetListCategories>(_getListCategories);
    on<GetListCategoriesAll>(_getListCategoriesAll);
    on<GetFoodsAll>(_onGetFoodsAll);

    // Get list restaurant
    on<GetRestaurantAll>(_onGetRestaurantAll);
  }

  Future<void>_getListCategories(GetListCategories event, Emitter<HomeState> emit) async {
    try{
      emit(state.copyWith(isLoading: true));
      final result = await _categoryRepositoryRemote.fetchData();
      final resultRestaurant = await _categoryRepositoryRemote.getAllRestaurant(code:'902070');
      final resultFood = await _foodRepositoryRemote.getFood(code: '41007428');

      emit(state.copyWith(listCategory: result,listRestaurant: resultRestaurant, listFoods: resultFood));
      emit(state.copyWith(isLoading: false));
    }on NetworkException catch(e){
      emit(state.copyWith(listCategory: [], title: e.message));
    }
  }

  Future<void>_getListCategoriesAll(GetListCategoriesAll event, Emitter<HomeState> emit) async {
    try{
      emit(state.copyWith(isLoading: true));
      final result = await _categoryRepositoryRemote.getAllCategory();
      emit(state.copyWith(listCategory: result));
      emit(state.copyWith(isLoading: false));
    }on NetworkException catch(e){
      emit(state.copyWith(listCategory: [], title: e.message));

    }

  }

  // Get list restaurant
  Future<void> _onGetRestaurantAll(GetRestaurantAll event, Emitter<HomeState> emit) async {
    try{
      emit(state.copyWith(isLoading: true));
      final result = await _categoryRepositoryRemote.getAllRestaurant(code: event.code);
      emit(state.copyWith(listRestaurant: result));
      emit(state.copyWith(isLoading: false));
    }on NetworkException catch(e){
      emit(state.copyWith(listRestaurant: [], title: e.message));
    }
  }

  Future<void> _onGetFoodsAll(GetFoodsAll event, Emitter<HomeState> emit) async {
  try{
    emit(state.copyWith(isLoading: true));
    final result = await _foodRepositoryRemote.getFoodByCategory(category: event.category,code: event.code);
    emit(state.copyWith(listFoodsCategory: result,title: event.title, category: event.category),
    );
    emit(state.copyWith(isLoading: false));


  } on NetworkException catch(e){
    emit(state.copyWith(listFoods: [], title: e.message));
  }
  }

}