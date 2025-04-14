import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/constants.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Dio dio = Dio();


  ProfileBloc() : super(const ProfileState()) {
    on<UpdatePositionEvent>(_onUpdatePositionEvent);
    on<GetUserAddressEvent>(_onGetUserAddressEvent);
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<CheckDefaultAddressEvent>(_onCheckDefaultAddressEvent);
  }

  void _onUpdatePositionEvent(
      UpdatePositionEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(position: event.position));
  }

  Future<void> _onGetUserAddressEvent(
      GetUserAddressEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {

      //  final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position
      //       .latitude},${position.longitude}&key=$googleApiKey';
      final response = await dio.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        queryParameters: {
          'latlng': '${event.position.latitude},${event.position.longitude}',
          'key': googleApiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;

        final address = data['results'][0]['formatted_address'];
        String? postalCode;
        final addressComponents = data['results'][0]['address_components'];
        for (var component in addressComponents) {
          if (component['types'].contains('locality')) {
            postalCode = component['long_name'];
            break;
          }
        }
        debugPrint('Address1: $address');
        debugPrint('Postal Code: $postalCode');
        emit(state.copyWith(
          isSuccess: true,
          address: address,
          postalCode: postalCode,
        ));
      } else {
        emit(state.copyWith(
          isFailed: true,
          errorMessage: 'Failed to fetch address',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isFailed: true,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onChangeTabEvent(
      ChangeTabEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }
  void _onCheckDefaultAddressEvent(
      CheckDefaultAddressEvent event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isDefault: event.isDefault));
  }
}
