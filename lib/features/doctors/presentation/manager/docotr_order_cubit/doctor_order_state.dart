part of 'doctor_order_cubit.dart';

abstract class DoctorOrdersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DoctorOrdersInitial extends DoctorOrdersState {}

class DoctorOrdersLoading extends DoctorOrdersState {}

class DoctorOrdersLoaded extends DoctorOrdersState {
  final List<Order> orders;

  DoctorOrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class DoctorOrdersError extends DoctorOrdersState {
  final String message;

  DoctorOrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
