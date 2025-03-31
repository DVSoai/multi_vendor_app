import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super( LoginState.initial()){
    on<ToggleShowPasswordLogin>((event, emit) {
      emit(LoginState(isShowPassword: !state.isShowPassword));
    });
  }

}