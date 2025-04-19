import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor_app/data/models/cart/cart_request_model.dart';
import 'package:multi_vendor_app/data/models/cart/cart_response.dart';
import 'package:multi_vendor_app/data/repositories/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepositoryRemote _cartRepository;

  CartBloc(this._cartRepository) : super(const CartState()) {
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveCartEvent>(_onRemoveCart);
    on<GetCartEvent>(_onGetCart);
  }

  Future<void> _onAddToCart(
      AddToCartEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading,action: CartAction.add));


    try {
      await _cartRepository.addToCart(event.cart);
      add(const GetCartEvent());
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to add to cart',
      ));
    }
  }

  Future<void> _onRemoveCart(
      RemoveCartEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading,action: CartAction.remove));
    try {
      await _cartRepository.deleteCart(event.productId);

      add(const GetCartEvent());
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to remove from cart',
      ));
    }
  }

  Future<void> _onGetCart(
      GetCartEvent event,
      Emitter<CartState> emit,
      ) async {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      final cart = await _cartRepository.getCart();

      debugPrint('Cart: ${cart.length}');
      emit(state.copyWith(
        status: CartStatus.success,
        listCart: cart,
        action: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CartStatus.failure,
        errorMessage: 'Failed to get cart',
      ));
    }
  }
}
