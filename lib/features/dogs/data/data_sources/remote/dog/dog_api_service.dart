import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../../core/constants/constants.dart';
import '../../../models/dog.dart';

part 'dog_api_service.g.dart';

@RestApi(baseUrl: apiBaseUrl)
abstract class DogApiService {
  factory DogApiService(Dio dio) = _DogApiService;

  @GET('1151549092634943488')
  Future<HttpResponse<List<DogModel>>> getDogs();
}
