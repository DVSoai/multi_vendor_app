
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/network/source/exception.dart';
import '../../../../../data/models/hook_models/restaurant_model.dart';
import '../../../../../data/repositories/categories/category_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState>{

  final CategoryRepositoryRemote _categoryRepositoryRemote;

  RestaurantBloc(this._categoryRepositoryRemote) : super(RestaurantState.initial()){
    on<GetNearbyRestaurant>(_onGetNearbyRestaurant);
  }

  Future<void> _onGetNearbyRestaurant(GetNearbyRestaurant event, Emitter<RestaurantState> emit) async {
    try{
      emit(state.copyWith(isLoading: true));
      final result = await _categoryRepositoryRemote.getAllRestaurant(code: '902070');

      emit(state.copyWith(listAllRestaurant: result));
      emit(state.copyWith(isLoading: false));
    }on NetworkException catch(e){
      emit(state.copyWith(error: e.message));
    }
  }
}