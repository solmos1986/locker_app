import 'package:locker_app/config/database.dart';
import 'package:locker_app/infrastructure/locker_model.dart';

class LockerRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<LockerModel> lockers) async {
    int count = 0;
    for (var locker in lockers) {
      await create(locker);
      count++;
    }
    return count;
  }

  Future<LockerModel> create(LockerModel locker) async {
    final query = await db.database;
    final id = await query.insert(LockerFields.tableName, locker.toJson());
    return locker.copy(id: id);
  }

  Future<LockerModel> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      LockerFields.tableName,
      columns: columns,
      where: '${LockerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LockerModel.fromJsonMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<LockerModel>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(LockerFields.tableName, orderBy: orderBy);
    return result.map((json) => LockerModel.fromJsonMap(json)).toList();
  }

  Future<int> update(LockerModel note) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      LockerFields.tableName,
      note.toJson(),
      where: '${LockerFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await LockeAppDatabase.instance.database;
    return await db.delete(
      LockerFields.tableName,
      where: '${LockerFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> resetDataBase() async {
    final query = await db.database;
    return await query.execute('''
        DELETE from users;
        DELETE from lockers;
     ''');
  }
}

class LockerFields {
  static const String tableName = 'lockers';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
