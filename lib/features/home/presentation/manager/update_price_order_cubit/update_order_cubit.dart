import 'package:bloc/bloc.dart';
import 'package:clinic/features/home/domain/usecase/fetch_order_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_order_state.dart';

class UpdatePriceOrderCubit extends Cubit<UpdateOrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;
  UpdatePriceOrderCubit(this.fetchOrdersUseCase) : super(UpdateOrderInitial());

  Future<void> updateOrderPrice(int orderId, int newPrice) async {
    emit(UpdateOrderLoading());
    try {
      await fetchOrdersUseCase.updateOrderPrice(orderId, newPrice);
      emit(UpdateOrderSuccess());
    } catch (e) {
      emit(UpdateOrderError(errormessage: e.toString()));
    }
  }
}
