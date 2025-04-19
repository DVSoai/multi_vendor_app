part of 'shipping_bloc.dart';

class ShippingState extends Equatable {
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final AddressModel? addressModel;
  final int tabIndex;
  final bool isDefault;
  final bool isSuccess;

  const ShippingState({
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
    this.addressModel,
    this.tabIndex =0,
    this.isDefault = false,
    this.isSuccess = false
  });

  ShippingState copyWith({
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    AddressModel? addressModel,
    int? tabIndex,
    bool? isDefault,
    bool? isSuccess
  }) {
    return ShippingState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      addressModel: addressModel ?? this.addressModel,
      tabIndex: tabIndex ?? this.tabIndex,
      isDefault: isDefault ?? this.isDefault,
      isSuccess: isSuccess ?? this.isSuccess
    );
  }



  @override
  List<Object?> get props => [isLoading,isError,errorMessage,addressModel,tabIndex,isDefault,isSuccess];
}