
part of 'phone_verification_bloc.dart';

class PhoneVerificationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final String errorMessage;
  final String verificationId;

  const PhoneVerificationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
    this.errorMessage = '',
    this.verificationId = '',
  });

  @override
  List<Object> get props => [isLoading, isSuccess, isFailed, errorMessage, verificationId];

  PhoneVerificationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailed,
    String? errorMessage,
    String? verificationId,
  }) {
    return PhoneVerificationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      errorMessage: errorMessage ?? this.errorMessage,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}