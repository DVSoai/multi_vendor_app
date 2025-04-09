part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class ToggleShowPasswordRegister extends RegisterEvent {
  const ToggleShowPasswordRegister();
}

class RegisterUser extends RegisterEvent {
  final RegisterModel registerModel;
  const RegisterUser({required this.registerModel});
}