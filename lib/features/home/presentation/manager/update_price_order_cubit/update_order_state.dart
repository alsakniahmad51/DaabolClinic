part of 'update_order_cubit.dart';

sealed class UpdateOrderState extends Equatable {
  const UpdateOrderState();

  @override
  List<Object> get props => [];
}

final class UpdateOrderInitial extends UpdateOrderState {}

final class UpdateOrderSuccess extends UpdateOrderState {}

final class UpdateOrderLoading extends UpdateOrderState {}

final class UpdateOrderError extends UpdateOrderState {
  final String errormessage;

  const UpdateOrderError({required this.errormessage});
}
