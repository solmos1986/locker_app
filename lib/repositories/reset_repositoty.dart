import 'package:locker_app/config/database.dart';

class ResetRepository {
  final db = LockeAppDatabase.instance;

  Future<void> inizializeDataBase() async {
    await LockeAppDatabase.instance.database;
  }

  Future<void> resetDataBase() async {
    final query = await db.database;

    /* await query.execute('''
        DELETE from user;
     ''');

    await query.execute('''
        DELETE from locker;
     '''); */
    await resetClient();
    await resetLocker();
    await resetUser();
    await resetController();
    await resetDoorSize();
    await resetDoor();
    await resetMovement();
    //insert
    await db.createClient(query);
    await db.createLocker(query);
    await db.createUser(query);
    await db.createController(query);
    await db.createDoorSize(query);
    await db.createDoor(query);
    await db.createMovement(query);
  }

  Future<void> resetClient() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS client;
     ''');
  }

  Future<void> resetLocker() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS locker;
     ''');
  }

  Future<void> resetUser() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS user;
     ''');
  }

  Future<void> resetController() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS controller;
     ''');
  }

  Future<void> resetDoorSize() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS door_size;
     ''');
  }

  Future<void> resetDoor() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS door;
     ''');
  }

  Future<void> resetMovement() async {
    final query = await db.database;
    await query.execute('''
        DROP TABLE IF EXISTS movement;
     ''');
  }
}
