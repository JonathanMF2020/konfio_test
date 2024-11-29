import 'package:konfiotest/features/dogs/data/models/dog.dart';

import '../../../../core/resources/data_state.dart';

abstract class DogRepository {
  // API Methods
  Future<DataState<List<DogModel>>> getDogs();
}
