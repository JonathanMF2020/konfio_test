import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/dog.dart';

part 'dog.g.dart';

@Entity(tableName: 'dogs')
@JsonSerializable()
class DogModel extends DogEntity {
  factory DogModel.fromJson(Map<String, dynamic> json) =>
      _$DogModelFromJson(json);
  const DogModel({
    this.id,
    super.dogName,
    super.description,
    super.age,
    super.image,
  });
  @PrimaryKey(autoGenerate: true)
  final int? id;

  Map<String, dynamic> toJson() => _$DogModelToJson(this);
}
