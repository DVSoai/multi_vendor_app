part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ToggleShowPasswordLogin extends LoginEvent {

  const ToggleShowPasswordLogin();
}