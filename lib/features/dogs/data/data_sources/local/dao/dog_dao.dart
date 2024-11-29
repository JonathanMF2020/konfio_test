import 'package:floor/floor.dart';
import 'package:konfiotest/features/dogs/data/models/dog.dart';

@dao
abstract class DogDao {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDog(DogModel dog);

  @Query('SELECT * FROM dogs')
  Future<List<DogModel>> findAllDogs();
}
