part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final LatLng position;
  final String address;
  final String postalCode;
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final bool isFailed;
  final int tabIndex;
  final bool isDefault;

  const ProfileState({
    this.position = const LatLng(0, 0),
    this.address = '',
    this.postalCode = '',
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.isFailed = false,
    this.tabIndex = 0,
    this.isDefault = false,

  });

  @override
  List<Object> get props => [isLoading, isSuccess, isFailed, errorMessage ?? '', address, postalCode, position, tabIndex, isDefault];

  ProfileState copyWith({
    LatLng? position,
    String? address,
    String? postalCode,
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    bool? isFailed,
    int? tabIndex,
    bool? isDefault,
  }) {
    return ProfileState(
      position: position ?? this.position,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
      tabIndex: tabIndex ?? this.tabIndex,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}