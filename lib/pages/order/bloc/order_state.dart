part of 'order_bloc.dart';

class OrderState extends Equatable {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final bool isSuccess;
  final String paymentUrl;

  const OrderState({
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
    this.isSuccess = false,
    this.paymentUrl = '',
  });

  factory OrderState.initial() => const OrderState();

  OrderState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    bool? isSuccess,
    String? paymentUrl,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      paymentUrl: paymentUrl ?? this.paymentUrl,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isError,
    errorMessage,
    isSuccess,
    paymentUrl,
  ];
}
