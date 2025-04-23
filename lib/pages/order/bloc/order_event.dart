part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class CreateOrderEvent extends OrderEvent {
  final String data;

  const CreateOrderEvent({required this.data});

  @override
  List<Object> get props => [data];
}

class PaymentEvent extends OrderEvent {
  final String data;

  const PaymentEvent({required this.data});

  @override
  List<Object> get props => [data];
}
