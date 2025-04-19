part of 'shipping_bloc.dart';

class ShippingEvent extends Equatable {
  const ShippingEvent();

  @override
  List<Object?> get props => [];
}

class AddShippingAddressEvent extends ShippingEvent {
 final Map<String, dynamic> address;

  const AddShippingAddressEvent({
    required this.address,
  });
  @override
  List<Object?> get props => [address];
}

// ✅ Sự kiện chuyển tab
class ChangeTabEvent extends ShippingEvent {
  final int tabIndex;

  const ChangeTabEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

// ✅ Sự kiện kiểm tra địa chỉ mặc định
class CheckDefaultAddressEvent extends ShippingEvent {
  final bool isDefault;

  const CheckDefaultAddressEvent(this.isDefault);

  @override
  List<Object?> get props => [isDefault];
}