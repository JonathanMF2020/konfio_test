import 'dart:async';

import 'package:floor/floor.dart';
import 'package:konfiotest/features/dogs/data/data_sources/local/dao/dog_dao.dart';
import 'package:konfiotest/features/dogs/data/models/dog.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [DogModel])
abstract class AppDatabase extends FloorDatabase {
  DogDao get dogDao;
}
