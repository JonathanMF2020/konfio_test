import 'package:konfiotest/features/dogs/data/models/dog.dart';
import 'package:konfiotest/features/dogs/domain/repository/dog_repository.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/use_case.dart';

class GetDogsUseCase implements UseCase<DataState<List<DogModel>>, void> {
  GetDogsUseCase(this.dogRepository);
  final DogRepository dogRepository;
  @override
  Future<DataState<List<DogModel>>> call({void params}) {
    return dogRepository.getDogs();
  }
}
