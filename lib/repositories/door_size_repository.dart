import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/door_size_entity.dart';

class DoorSizeRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<DoorSizeEntity> clients) async {
    int count = 0;
    for (var client in clients) {
      await create(client);
      count++;
    }
    return count;
  }

  Future<DoorSizeEntity> create(DoorSizeEntity doorSize) async {
    final query = await db.database;
    final id = await query.insert(DoorSizeFields.tableName, doorSize.toJson());
    return doorSize.copy(doorSizeId: id);
  }

  Future<DoorSizeEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      DoorSizeFields.tableName,
      columns: columns,
      where: '${DoorSizeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DoorSizeEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DoorSizeEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(DoorSizeFields.tableName, orderBy: orderBy);
    return result.map((json) => DoorSizeEntity.fromJson(json)).toList();
  }

  Future<int> update(DoorSizeEntity doorSize) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      DoorSizeFields.tableName,
      doorSize.toJson(),
      where: '${DoorSizeFields.id} = ?',
      whereArgs: [doorSize.doorSizeId],
    );
  }

  Future<int> delete(int id) async {
    final db = await LockeAppDatabase.instance.database;
    return await db.delete(
      DoorSizeFields.tableName,
      where: '${DoorSizeFields.id} = ?',
      whereArgs: [id],
    );
  }
}

class DoorSizeFields {
  static const String tableName = 'door_size';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
