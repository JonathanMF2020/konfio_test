import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konfiotest/core/resources/data_state.dart';
import 'package:konfiotest/features/dogs/domain/use_cases/get_dogs.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_event.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc(this.getDogsUseCase) : super(DogLoading()) {
    on<GetDogs>(onGetDogs);
  }
  final GetDogsUseCase getDogsUseCase;

  Future<void> onGetDogs(GetDogs event, Emitter<DogState> emit) async {
    final dataState =
        await getDogsUseCase(); // _getArticleUseCase.call() is equal to _getArticleUseCase() in Dart (Object.call() == Object())
    if (dataState is DataSuccess) {
      emit(DogDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      if (kDebugMode) {
        print("[Error] ${dataState.error.toString()}");
      }
      emit(DogError(dataState.error!));
    }
  }
}
