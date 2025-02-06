part of 'order_cubit.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  final DateTime? selectedDate; // تاريخ المستخدم
  OrderLoaded(this.orders, {this.selectedDate});
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
