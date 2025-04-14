part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class UpdatePositionEvent extends ProfileEvent {
  final LatLng position;

  const UpdatePositionEvent(this.position);

  @override
  List<Object?> get props => [position];
}

// ✅ Sự kiện lấy địa chỉ từ vị trí
class GetUserAddressEvent extends ProfileEvent {
  final LatLng position;

  const GetUserAddressEvent(this.position);

  @override
  List<Object?> get props => [position];
}

// ✅ Sự kiện chuyển tab
class ChangeTabEvent extends ProfileEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

// ✅ Sự kiện kiểm tra địa chỉ mặc định
class CheckDefaultAddressEvent extends ProfileEvent {
  final bool isDefault;

  const CheckDefaultAddressEvent(this.isDefault);

  @override
  List<Object?> get props => [isDefault];
}

