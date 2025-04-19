import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/address/address_model.dart';
import '../../../../data/repositories/address/addresses_repository.dart';

part  'address_event.dart';
part  'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState>{
  final AddressesRepositoryRemote _addressesRepositoryRemote;
  AddressBloc(
    this._addressesRepositoryRemote,
      ) : super(const AddressState()) {
    on<GetAddressesEvent>(_getAddresses);
  }

  Future<void> _getAddresses(GetAddressesEvent event, Emitter<AddressState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final addresses = await _addressesRepositoryRemote.getAddressesAll();
      emit(state.copyWith(addresses: addresses, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isError: true, errorMessage: e.toString(), isLoading: false));
    }
  }
}