part of 'login_bloc.dart';

class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ToggleShowPasswordLogin extends LoginEvent {

  const ToggleShowPasswordLogin();
}

class LoginSubmitted extends LoginEvent {
 final LoginModel loginModel;

  const LoginSubmitted({required this.loginModel});

  @override
  List<Object> get props => [loginModel];
}