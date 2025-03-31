part of 'login_bloc.dart';

 class LoginState extends Equatable {
  final bool isShowPassword;
  const LoginState({required this.isShowPassword});

  factory LoginState.initial() => const LoginState(isShowPassword: false);

  @override
  List<Object> get props => [isShowPassword];
}