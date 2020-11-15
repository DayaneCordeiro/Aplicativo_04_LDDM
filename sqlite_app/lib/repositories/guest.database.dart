import 'dart:async';
import 'package:sqlite_app/models/guest.model.dart';
import 'package:sqlite_app/repositories/guest.dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'guest.database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Guest])
abstract class AppDatabase extends FloorDatabase {
  GuestDao get guestDao;
}
