import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clinic/features/home/domain/Entities/order.dart';
import 'package:clinic/features/home/domain/usecase/fetch_order_usecase.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;

  OrderCubit(this.fetchOrdersUseCase) : super(OrderInitial());

  Future<void> fetchOrders(DateTime startDate, DateTime endDate) async {
    emit(OrderLoading());
    try {
      final orders = await fetchOrdersUseCase(startDate, endDate);
      emit(OrderLoaded(orders));
    } catch (e) {
      if (e is SocketException) {
        emit(OrderError("لا يوجد اتصال بالإنترنت"));
      } else {
        emit(OrderError(e.toString()));
      }
    }
  }
}
