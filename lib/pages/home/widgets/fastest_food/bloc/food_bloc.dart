import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor_app/data/repositories/food/food_repository.dart';

import '../../../../../data/models/hook_models/food_model.dart';

part 'food_event.dart';
part 'food_state.dart';


class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepositoryRemote foodRepositoryRemote;
  FoodBloc({
    required this.foodRepositoryRemote,
}) : super(FoodState.initial()) {
    on<GetAllFoods>(_onGetAllFoods);
  }

  Future<void> _onGetAllFoods(GetAllFoods event, Emitter<FoodState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await foodRepositoryRemote.getAllFood(code: '41007428');
      emit(state.copyWith(foods: result));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }


}