import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:konfiotest/features/dogs/data/models/dog.dart';

abstract class DogState extends Equatable {
  const DogState();

  @override
  List<Object> get props => [];
}

class DogLoading extends DogState {}

class DogDone extends DogState {
  const DogDone(this.dogs);
  final List<DogModel> dogs;
}

class DogError extends DogState {
  const DogError(this.error);
  final DioException error;
}
