import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor_app/data/repositories/orders/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepositoryRemote _orderRepositoryRemote;
  final Dio _dio = Dio();

  OrderBloc(this._orderRepositoryRemote) : super(OrderState.initial()) {
    on<CreateOrderEvent>(_onCreateOrderEvent);
    on<PaymentEvent>(_onPaymentEvent);
  }

  Future<void> _onCreateOrderEvent(CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
      errorMessage: '',
      isSuccess: false,
    ));
    try {
      await _orderRepositoryRemote.createOrder(event.data);
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onPaymentEvent(PaymentEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
      errorMessage: '',
      isSuccess: false,
    ));

    try {
      const String url = 'https://courcepaymentserver-production.up.railway.app/stripe/create-checkout-session';
      final response = await _dio.post(
        url,
        data: event.data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['url'] != null) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          paymentUrl: response.data['url'],
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          errorMessage: 'Không thể tạo phiên thanh toán.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isError: true,
        errorMessage: e.toString(),
      ));
    }
  }
}
