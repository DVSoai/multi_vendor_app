part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent{

 final CartRequestModel cart;
  const AddToCartEvent({required this.cart});
  @override
  List<Object?> get props => [cart];
}
class RemoveCartEvent extends CartEvent{
  final String productId;
  const RemoveCartEvent({required this.productId});
  @override
  List<Object?> get props => [productId];
}
class GetCartEvent extends CartEvent{
  const GetCartEvent();
  @override
  List<Object?> get props => [];
}