part of 'login_bloc.dart';
enum AuthStatus { initial, loading, success, failure }
class LoginState extends Equatable {
  final bool isShowPassword;
  final bool isLoginSuccess;
  final bool isFailure;
  final bool isLoginLoading;
  final String? message;

  const LoginState({
    required this.isShowPassword,
    required this.isLoginSuccess,
    required this.isFailure,
    required this.isLoginLoading,
    this.message,
  });

  factory LoginState.initial() => const LoginState(
        isShowPassword: false,
        isLoginSuccess: false,
        isFailure: false,
        isLoginLoading: false,
        message: null,
      );

  LoginState copyWith({
    bool? isShowPassword,
    bool? isLoginSuccess,
    bool? isFailure,
    bool? isLoginLoading,
    String? message,
  }) {
    return LoginState(
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
      isFailure: isFailure ?? this.isFailure,
      isLoginLoading: isLoginLoading ?? this.isLoginLoading,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props =>
      [isShowPassword, isLoginSuccess, isFailure, isLoginLoading, message??''];
}
