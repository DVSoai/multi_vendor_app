import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent,ShippingState>{
   ShippingBloc() : super(const ShippingState());
}