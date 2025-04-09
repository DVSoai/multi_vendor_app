part of 'email_verification_bloc.dart';

abstract class EmailVerificationEvent extends Equatable {
  const EmailVerificationEvent();

  @override
  List<Object?> get props => [];
}

class EmailVerificationCodeChanged extends EmailVerificationEvent {
  final String verificationCode;

  const EmailVerificationCodeChanged(this.verificationCode);

  @override
  List<Object?> get props => [verificationCode];
}