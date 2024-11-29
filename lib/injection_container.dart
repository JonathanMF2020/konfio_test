import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:konfiotest/features/dogs/data/data_sources/remote/dog/dog_api_service.dart';
import 'package:konfiotest/features/dogs/data/repository/dog_repository_impl.dart';
import 'package:konfiotest/features/dogs/domain/repository/dog_repository.dart';
import 'package:konfiotest/features/dogs/domain/use_cases/get_dogs.dart';
import 'package:konfiotest/features/dogs/presentation/bloc/dog/dog_bloc.dart';

import 'core/dio_interceptor/dio_interceptor.dart';
import 'features/dogs/data/data_sources/local/app_database.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  final dio = Dio();
  dio.interceptors.add(DioInterceptor());
  sl.registerSingleton<Dio>(dio);

  // Data Sources
  // Remotes
  sl.registerSingleton<DogApiService>(DogApiService(sl()));
  // Local
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Repository
  sl.registerLazySingleton<DogRepository>(() => DogRepositoryImpl(sl(), sl()));
  // Use cases
  sl.registerLazySingleton(() => GetDogsUseCase(sl()));
  // Blocs
  sl.registerFactory(() => DogBloc(sl()));
}
