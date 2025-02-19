

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc() : super(HomeState.initial()){
    on<UpdateCategories>((event, emit) {
      emit(state.copyWith(category: state.category));
    });
    on<UpdateTitle>((event, emit) {
      emit(state.copyWith(title: state.title));
    });
    on<UpdateCategoryAndTitle>((event, emit) {
      emit(state.copyWith(category: event.category, title: event.title));
    });
  }

}