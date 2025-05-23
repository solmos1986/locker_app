import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/locker_entity.dart';

class LockerRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<LockerEntity> lockers) async {
    int count = 0;
    for (var locker in lockers) {
      await create(locker);
      count++;
    }
    return count;
  }

  Future<LockerEntity> create(LockerEntity locker) async {
    final query = await db.database;
    final id = await query.insert(LockerFields.tableName, locker.toJson());
    return locker.copy(lockerId: id);
  }

  Future<LockerEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      LockerFields.tableName,
      columns: columns,
      where: '${LockerFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LockerEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<LockerEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' locker_id DESC';
    final result = await db.query(LockerFields.tableName, orderBy: orderBy);
    return result.map((json) => LockerEntity.fromJson(json)).toList();
  }

  Future<int> update(LockerEntity note) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      LockerFields.tableName,
      note.toJson(),
      where: '${LockerFields.id} = ?',
      whereArgs: [note.lockerId],
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
  static const String tableName = 'locker';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
