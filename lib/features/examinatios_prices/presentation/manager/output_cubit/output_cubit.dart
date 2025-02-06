import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/fetch_output_uscase.dart';
import 'package:clinic/features/examinatios_prices/domain/usecases/update_output_price_usecase.dart';
import 'package:clinic/features/home/domain/Entities/output.dart';

part 'output_state.dart';

class OutputCubit extends Cubit<OutputState> {
  final FetchOutputDetailsUseCase fetchOutputUseCase;
  final UpdateOutputPriceUseCase updateOutputPriceUseCase;

  OutputCubit({
    required this.fetchOutputUseCase,
    required this.updateOutputPriceUseCase,
  }) : super(OutputInitial());

  Future<void> fetchOutputDetails() async {
    emit(OutputLoading());
    try {
      final details = await fetchOutputUseCase();
      emit(OutputLoaded(output: details));
    } catch (error) {
      emit(OutputError(message: error.toString()));
    }
  }

  Future<void> updateOutputPrice(int id, int newPrice) async {
    emit(OutputUpdatingPrice());
    try {
      await updateOutputPriceUseCase(id, newPrice);
      await fetchOutputDetails();
    } catch (error) {
      emit(OutputError(message: error.toString()));
    }
  }
}
