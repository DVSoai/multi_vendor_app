import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/core/network/local/global_storage.dart';
import 'package:multi_vendor_app/data/models/auth/login_model.dart';
import 'package:multi_vendor_app/data/repositories/auth/login/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final LoginRepositoryRemote loginRepositoryRemote;
  final GlobalStorage globalStorage;
  LoginBloc({required this.loginRepositoryRemote,required this.globalStorage}) : super( LoginState.initial()){
    on<ToggleShowPasswordLogin>((event, emit) {
      emit(state.copyWith(isShowPassword: !state.isShowPassword));
    });

    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void>_onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoginLoading: true));
    Future.delayed(const Duration(seconds: 2));
    try {
      final user = await loginRepositoryRemote.login(event.loginModel);
      await globalStorage.saveToken(user.userToken!);
      debugPrint('Token: ${user.userToken}');
      debugPrint('User ID: ${user.id}');
      if(user.userToken != null && user.id != null){
        await globalStorage.saveIsLoggedIn(true);
        await globalStorage.saveUser(user);
        emit(state.copyWith(isLoginSuccess: true, isLoginLoading: false));
      }
      debugPrint('Done');

    } catch (e) {
      debugPrint('Error: $e');
      emit(state.copyWith(isFailure: true, isLoginLoading: false, message: e.toString()));
    }
  }

}