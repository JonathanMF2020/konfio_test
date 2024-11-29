import 'package:equatable/equatable.dart';

class DogEntity extends Equatable {
  const DogEntity({this.dogName, this.description, this.age, this.image});
  final String? dogName;
  final String? description;
  final int? age;
  final String? image;

  @override
  List<Object?> get props {
    return [dogName, description, age, image];
  }
}
