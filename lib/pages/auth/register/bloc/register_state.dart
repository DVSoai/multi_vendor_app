part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isShowPassword;
  final bool isRegisterLoading;
  final bool isRegisterSuccess;
  final bool isFailure;
  final String? message;
  const RegisterState( {required this.isRegisterLoading,required this.isRegisterSuccess,required this.isFailure, this.message,required this.isShowPassword});

  factory RegisterState.initial() => const RegisterState(
      isShowPassword: false,
      isRegisterLoading: false,
      isRegisterSuccess: false,
      isFailure: false,
      message: null
  );

  RegisterState copyWith({
    bool? isShowPassword,
    bool? isRegisterLoading,
    bool? isRegisterSuccess,
    bool? isFailure,
    String? message,
  }) {
    return RegisterState(
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isRegisterLoading: isRegisterLoading ?? this.isRegisterLoading,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
      isFailure: isFailure ?? this.isFailure,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [isShowPassword,isRegisterLoading,isRegisterSuccess,isFailure,message ?? ''];
}