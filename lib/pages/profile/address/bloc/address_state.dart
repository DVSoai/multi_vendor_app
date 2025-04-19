part of 'address_bloc.dart';


class AddressState extends Equatable{
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final List<AddressModel> addresses;

  const AddressState({
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
    this.addresses = const [],
  });

  AddressState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    List<AddressModel>? addresses,
  }) {
    return AddressState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        isLoading,
        isError,
        errorMessage,
        addresses,
      ];
}