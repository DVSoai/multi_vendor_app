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


