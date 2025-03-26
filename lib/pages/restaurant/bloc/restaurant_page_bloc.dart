import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_page_event.dart';
part 'restaurant_page_state.dart';

class RestaurantPageBloc extends Bloc<RestaurantPageEvent,RestaurantPageState>{
  RestaurantPageBloc() : super(const RestaurantPageState(count: 1)){
  }



}