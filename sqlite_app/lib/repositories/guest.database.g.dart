// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest.database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  GuestDao _guestDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Guest` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `status` TEXT, `email` TEXT, `cellPhone` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  GuestDao get guestDao {
    return _guestDaoInstance ??= _$GuestDao(database, changeListener);
  }
}

class _$GuestDao extends GuestDao {
  _$GuestDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _guestInsertionAdapter = InsertionAdapter(
            database,
            'Guest',
            (Guest item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'email': item.email,
                  'cellPhone': item.cellPhone
                }),
        _guestUpdateAdapter = UpdateAdapter(
            database,
            'Guest',
            ['id'],
            (Guest item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'email': item.email,
                  'cellPhone': item.cellPhone
                }),
        _guestDeletionAdapter = DeletionAdapter(
            database,
            'Guest',
            ['id'],
            (Guest item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'email': item.email,
                  'cellPhone': item.cellPhone
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _guestMapper = (Map<String, dynamic> row) => Guest(
      id: row['id'] as int,
      name: row['name'] as String,
      status: row['status'] as String,
      email: row['email'] as String,
      cellPhone: row['cellPhone'] as String);

  final InsertionAdapter<Guest> _guestInsertionAdapter;

  final UpdateAdapter<Guest> _guestUpdateAdapter;

  final DeletionAdapter<Guest> _guestDeletionAdapter;

  @override
  Future<List<Guest>> getAll() async {
    return _queryAdapter.queryList('SELECT * FROM Guest order by name',
        mapper: _guestMapper);
  }

  @override
  Future<Guest> getGuestById(int id) async {
    return _queryAdapter.query('SELECT * from Guest where id = ?',
        arguments: <dynamic>[id], mapper: _guestMapper);
  }

  @override
  Future<int> insertGuest(Guest p) {
    return _guestInsertionAdapter.insertAndReturnId(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateGuest(Guest p) {
    return _guestUpdateAdapter.updateAndReturnChangedRows(
        p, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteGuest(Guest p) {
    return _guestDeletionAdapter.deleteAndReturnChangedRows(p);
  }
}
