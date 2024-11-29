// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DogModel _$DogModelFromJson(Map<String, dynamic> json) => DogModel(
      id: (json['id'] as num?)?.toInt(),
      dogName: json['dogName'] as String?,
      description: json['description'] as String?,
      age: (json['age'] as num?)?.toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$DogModelToJson(DogModel instance) => <String, dynamic>{
      'dogName': instance.dogName,
      'description': instance.description,
      'age': instance.age,
      'image': instance.image,
      'id': instance.id,
    };
