part of 'cart_bloc.dart';

enum CartStatus { initial, loading, success, failure }
enum CartAction { add, remove }

class CartState extends Equatable {
  final CartStatus status;
  final String? errorMessage;
  final List<CartResponseModel> listCart;
  final CartAction? action;


  const CartState({
    this.status = CartStatus.initial,
    this.errorMessage,
    this.listCart = const [],
    this.action,
  });

  CartState copyWith({
    CartStatus? status,
    String? errorMessage,
    List<CartResponseModel>? listCart,
    CartAction? action,
  }) {
    return CartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      listCart: listCart ?? this.listCart,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    listCart,
    action,
  ];
}
