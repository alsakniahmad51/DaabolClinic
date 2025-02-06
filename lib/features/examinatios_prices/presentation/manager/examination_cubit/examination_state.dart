part of 'examination_cubit.dart';

abstract class ExaminationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExaminationInitial extends ExaminationState {}

class ExaminationLoading extends ExaminationState {}

class ExaminationLoaded extends ExaminationState {
  final List<ExaminationDetail> details;
  final List<Prices> prices;

  ExaminationLoaded({
    required this.details,
    required this.prices,
  });

  @override
  List<Object?> get props => [details];
}

class ExaminationUpdatingPrice extends ExaminationState {}

class ExaminationError extends ExaminationState {
  final String message;

  ExaminationError({required this.message});

  @override
  List<Object?> get props => [message];
}
