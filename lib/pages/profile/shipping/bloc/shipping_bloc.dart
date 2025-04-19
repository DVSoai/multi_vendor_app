import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/data/models/address/address_model.dart';

import '../../../../data/repositories/address/addresses_repository.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent,ShippingState>{
   final AddressesRepositoryRemote _addressesRepositoryRemote;
   ShippingBloc(this._addressesRepositoryRemote) : super(const ShippingState()){
      on<AddShippingAddressEvent>(_onGetShippingAddressEvent);
      on<ChangeTabEvent>(_onChangeTabEvent);
      on<CheckDefaultAddressEvent>(_onCheckDefaultAddressEvent);
   }

   Future<void>_onGetShippingAddressEvent(
        AddShippingAddressEvent event,
        Emitter<ShippingState> emit,
       )async{
      emit(state.copyWith(isLoading: true));
      try {
         final result = await _addressesRepositoryRemote.addAddress(event.address);
             emit(state.copyWith(isLoading:false, addressModel : result,isSuccess: true));

      }catch(e){
         emit(state.copyWith(isLoading: false, isError: true, errorMessage: e.toString()));
          debugPrint('Error: $e');
      }

   }


   void _onChangeTabEvent(
       ChangeTabEvent event, Emitter<ShippingState> emit) {
      emit(state.copyWith(tabIndex: event.tabIndex));
   }
   void _onCheckDefaultAddressEvent(
       CheckDefaultAddressEvent event, Emitter<ShippingState> emit) {
      emit(state.copyWith(isDefault: event.isDefault));
   }
}