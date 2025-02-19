

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'tab_index_event.dart';
part 'tab_index_state.dart';

class TabIndexBloc extends Bloc<TabIndexEvent, TabIndexState> {
  TabIndexBloc() : super(TabIndexState.initial()){
    on<TabIndexChanged>((event, emit) {
      emit(TabIndexState(index: event.index));
    });
  }


}