part of 'update_state_order_cubit.dart';

sealed class UpdateStateOrderState extends Equatable {
  const UpdateStateOrderState();

  @override
  List<Object> get props => [];
}

final class UpdateStateOrderInitial extends UpdateStateOrderState {}

final class UpdateStateOrderLoading extends UpdateStateOrderState {}

final class UpdateStateOrderFailure extends UpdateStateOrderState {
  final String errMessage;

  const UpdateStateOrderFailure({required this.errMessage});
}

final class UpdateStateOrderSucsecc extends UpdateStateOrderState {}
