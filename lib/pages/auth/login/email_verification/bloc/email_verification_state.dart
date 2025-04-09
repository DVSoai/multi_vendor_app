part of 'email_verification_bloc.dart';

class EmailVerificationState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? verificationCode;
  final bool isFailed;

  const EmailVerificationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.verificationCode,
    this.isFailed = false,
  });

  EmailVerificationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? verificationCode,
    bool? isFailed,
  }) {
    return EmailVerificationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      verificationCode: verificationCode ?? this.verificationCode,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        verificationCode,
        isFailed,
      ];
}
