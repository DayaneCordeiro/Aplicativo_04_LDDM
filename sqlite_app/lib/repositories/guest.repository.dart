import 'package:sqlite_app/models/guest.model.dart';
import 'package:sqlite_app/repositories/guest.dao.dart';
import 'package:sqlite_app/repositories/guest.database.dart';

class GuestRepository {
  static GuestRepository _instance;
  GuestRepository._();

  AppDatabase database;
  GuestDao guestDao;

  static Future<GuestRepository> getInstance() async {
    if (_instance != null) return _instance;
    _instance = GuestRepository._();
    await _instance.init();
    return _instance;
  }

  Future<void> init() async {
    database = await $FloorAppDatabase.databaseBuilder('guests.db').build();
    guestDao = database.guestDao;
  }

  Future<List<Guest>> getAll() async {
    try {
      return await guestDao.getAll();
    } catch (e) {
      return List<Guest>();
    }
  }

  Future<bool> create(Guest p) async {
    try {
      await guestDao.insertGuest(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Guest p) async {
    try {
      await guestDao.updateGuest(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      Guest p = await guestDao.getGuestById(id);
      await guestDao.deleteGuest(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
