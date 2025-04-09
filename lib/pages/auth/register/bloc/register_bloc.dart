import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor_app/data/repositories/auth/register/register_repository.dart';

import '../../../../data/models/auth/register_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepositoryRemote _registerRepositoryRemote;
  RegisterBloc(this._registerRepositoryRemote) : super( RegisterState.initial()){
    on<ToggleShowPasswordRegister>((event, emit) {
      emit(state.copyWith(isShowPassword: !state.isShowPassword));
    });

    on<RegisterUser>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(RegisterUser event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isRegisterLoading: true,isRegisterSuccess: false));
    try {
      await _registerRepositoryRemote.register(event.registerModel);

      emit(state.copyWith(isRegisterLoading: false, isRegisterSuccess: true));
    } catch (e) {
      emit(state.copyWith(isRegisterLoading: false, isFailure: true, message: e.toString()));
    }
  }

}