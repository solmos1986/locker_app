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

    await db.execute('''
        CREATE TABLE users (
        id INTEGER NOT NULL,
        lockerId INTEGER  NOT NULL,
        name TEXT NOT NULL,
        state INTEGER NOT NULL
      )
        ''');
    await db.execute('''
       CREATE TABLE lockers (
        id INTEGER NOT NULL,
        clientId INTEGER  NOT NULL,
        macAdd TEXT NOT NULL,
        state INTEGER NOT NULL
      )
      ''');
  }
}
