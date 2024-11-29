import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:konfiotest/core/resources/data_state.dart';
import 'package:konfiotest/features/dogs/data/data_sources/local/app_database.dart';
import 'package:konfiotest/features/dogs/data/data_sources/remote/dog/dog_api_service.dart';
import 'package:konfiotest/features/dogs/data/models/dog.dart';
import 'package:konfiotest/features/dogs/domain/repository/dog_repository.dart';

class DogRepositoryImpl implements DogRepository {
  DogRepositoryImpl(this.dogApiService, this.database);
  final DogApiService dogApiService;
  final AppDatabase database;
  @override
  Future<DataState<List<DogModel>>> getDogs() async {
    try {
      final dogs = await database.dogDao.findAllDogs();
      if (dogs.isEmpty) {
        if (kDebugMode) {
          print("Ingreso en modo sin datos en dispositivo: $dogs");
        }
        final httpResponse = await dogApiService.getDogs();
        if (httpResponse.response.statusCode == HttpStatus.ok) {
          httpResponse.data.forEach(database.dogDao.insertDog);
          return DataSuccess(httpResponse.data);
        } else {
          return DataFailed(
            DioException(
              requestOptions: httpResponse.response.requestOptions,
              response: httpResponse.response,
              error: httpResponse.response.statusMessage,
              type: DioExceptionType.badResponse,
            ),
          );
        }
      } else {
        if (kDebugMode) {
          print("Ingreso en modo con datos en dispositivo: $dogs");
        }
        return DataSuccess(dogs);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrintStack(stackTrace: e.stackTrace);
      }
      return DataFailed(e);
    }
  }
}
