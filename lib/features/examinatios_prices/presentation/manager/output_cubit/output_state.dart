part of 'output_cubit.dart';

abstract class OutputState extends Equatable {
  const OutputState();

  @override
  List<Object?> get props => [];
}

class OutputInitial extends OutputState {}

class OutputLoading extends OutputState {}

class OutputLoaded extends OutputState {
  final List<Output> output;

  const OutputLoaded({required this.output});

  @override
  List<Object?> get props => [output];
}

class OutputUpdatingPrice extends OutputState {}

class OutputError extends OutputState {
  final String message;

  const OutputError({required this.message});

  @override
  List<Object?> get props => [message];
}
