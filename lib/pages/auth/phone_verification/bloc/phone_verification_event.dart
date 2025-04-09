part of 'phone_verification_bloc.dart';

abstract class PhoneVerificationEvent extends Equatable {
  const PhoneVerificationEvent();

  @override
  List<Object> get props => [];
}
class PhoneVerificationStarted extends PhoneVerificationEvent {
  final String phoneNumber;
  const PhoneVerificationStarted({required this.phoneNumber});
}

class PhoneCodeEntered extends PhoneVerificationEvent {
  final String verificationId;
  final String smsCode;
  const PhoneCodeEntered({required this.verificationId, required this.smsCode});
}
