import 'package:sqlite_app/models/guest.model.dart';
import 'package:floor/floor.dart';

@dao
abstract class GuestDao {
  @Query('SELECT * FROM Guest order by name')
  Future<List<Guest>> getAll();

  @Query("SELECT * from Guest where id = :id")
  Future<Guest> getGuestById(int id);

  @insert
  Future<int> insertGuest(Guest p);

  @update
  Future<int> updateGuest(Guest p);

  @delete
  Future<int> deleteGuest(Guest p);
}
