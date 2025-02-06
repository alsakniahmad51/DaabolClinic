import 'package:bloc/bloc.dart';
import 'package:clinic/features/home/domain/usecase/fetch_order_usecase.dart';
import 'package:equatable/equatable.dart';

part 'update_state_order_state.dart';

class UpdateStateOrderCubit extends Cubit<UpdateStateOrderState> {
  final FetchOrdersUseCase fetchOrdersUseCase;
  UpdateStateOrderCubit(this.fetchOrdersUseCase)
      : super(UpdateStateOrderInitial());
  Future<void> updateOrderState(int orderId) async {
    emit(UpdateStateOrderLoading());
    try {
      await fetchOrdersUseCase.updateOredrStare(orderId);
      emit(UpdateStateOrderSucsecc());
    } catch (e) {
      emit(UpdateStateOrderFailure(errMessage: e.toString()));
    }
  }
}
