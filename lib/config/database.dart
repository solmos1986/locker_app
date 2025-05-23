import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class LockeAppDatabase {
  static final LockeAppDatabase instance = LockeAppDatabase._internal();

  static Database? _database;

  LockeAppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await sql.getDatabasesPath();

    final path = '$databasePath/lock_app.db';
    return await sql.openDatabase(
      path,
      version: 1,
      readOnly: false,
      onCreate: (db, version) async {
        await _createDatabase(db, version);
      },
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    /* await db.execute('''
        CREATE TABLE client (
        client_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        name TEXT NOT NULL,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
        ''');

    await db.execute('''
        CREATE TABLE locker (
        locker_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        client_id INTEGER NOT NULL,
        macAdd TEXT NOT NULL,
        state TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(client_id) REFERENCES client(client_id)
      )
        '''); */

    await createClient(db);
    await createLocker(db);
    await createUser(db);
    await createController(db);
    await createDoorSize(db);
    await createDoor(db);
    await createMovement(db);

    /* await db.execute('''
        CREATE TABLE user (
        user_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        locker_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        state TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(locker_id) REFERENCES locker(locker_id)
      )
        ''');

    await db.execute('''
        CREATE TABLE controller (
        controller_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        locker_id INTEGER  NOT NULL,
        address485 TEXT NOT NULL,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(locker_id) REFERENCES locker(locker_id)
      )
        ''');

    await db.execute('''
        CREATE TABLE door_size (
        door_size_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
        ''');

    await db.execute('''
        CREATE TABLE door (
        door_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        door_size_id INTEGER NOT NULL,
        controller_id INTEGER NOT NULL,
        number INTEGER NOT NULL,
        channel TEXT NOT NULL,
        state TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(door_size_id) REFERENCES door_size(door_size_id),
        FOREIGN KEY(controller_id) REFERENCES controller(controller_id)
      )
        ''');

    await db.execute('''
        CREATE TABLE movement (
        movement_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        door_id INTEGER NOT NULL,
        code TEXT NOT NULL,
        delivered TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(door_id) REFERENCES door(door_id)
      )
        '''); */
  }

  Future<void> createClient(Database db) async {
    await db.execute('''
        CREATE TABLE client (
        client_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        name TEXT NOT NULL,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime'))
      )
        ''');
  }

  Future<void> createLocker(Database db) async {
    await db.execute('''
        CREATE TABLE locker (
        locker_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
        client_id INTEGER NOT NULL,
        macAdd TEXT NOT NULL,
        state TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime')),
        FOREIGN KEY(client_id) REFERENCES client(client_id)
      )
        ''');
  }

  Future<void> createUser(Database db) async {
    await db.execute('''
        CREATE TABLE user (
        user_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        client_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        state TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime')),
        FOREIGN KEY(client_id) REFERENCES client(client_id)
      )
        ''');
  }

  Future<void> createController(Database db) async {
    await db.execute('''
        CREATE TABLE controller (
        controller_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        locker_id INTEGER  NOT NULL,
        address485 TEXT NOT NULL,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime')),
        FOREIGN KEY(locker_id) REFERENCES locker(locker_id)
      )
        ''');
  }

  Future<void> createDoorSize(Database db) async {
    await db.execute('''
        CREATE TABLE door_size (
        door_size_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime'))
      )
        ''');
  }

  Future<void> createDoor(Database db) async {
    await db.execute('''
        CREATE TABLE door (
        door_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        door_size_id INTEGER NOT NULL,
        controller_id INTEGER NOT NULL,
        number INTEGER NOT NULL,
        channel TEXT NOT NULL,
        state TINYINT NOT NULL DEFAULT 1,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime')),
        FOREIGN KEY(door_size_id) REFERENCES door_size(door_size_id),
        FOREIGN KEY(controller_id) REFERENCES controller(controller_id)
      )
        ''');
  }

  Future<void> createMovement(Database db) async {
    await db.execute('''
        CREATE TABLE movement (
        movement_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        door_id INTEGER NOT NULL,
        code TEXT NOT NULL,
        delivered TINYINT NOT NULL DEFAULT 0,
        create_at TIMESTAMP DEFAULT (datetime('now','localtime')),
        FOREIGN KEY(door_id) REFERENCES door(door_id),
        FOREIGN KEY(user_id) REFERENCES user(user_id)
      )
        ''');
  }
}
