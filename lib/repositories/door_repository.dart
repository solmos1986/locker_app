import 'package:locker_app/config/database.dart';
import 'package:locker_app/infrastructure/door_model.dart';

class DoorRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<DoorModel> doors) async {
    int count = 0;
    for (var door in doors) {
      await create(door);
      count++;
    }
    return count;
  }

  Future<DoorModel> create(DoorModel door) async {
    final query = await db.database;
    final id = await query.insert(DoorSizeFields.tableName, door.toJson());
    return door.copy(doorId: id);
  }

  Future<List<DoorModel>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' locker_id DESC';
    final result = await db.query(DoorSizeFields.tableName, orderBy: orderBy);
    return result.map((json) => DoorModel.fromJson(json)).toList();
  }

  Future<DoorModel> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      DoorSizeFields.tableName,
      columns: columns,
      where: '${DoorSizeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DoorModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DoorModel>> readDoorAvailable() async {
    final db = await LockeAppDatabase.instance.database;
    const query =
        ' SELECT door.* from  door LEFT JOIN movement on door.door_id=movement.door_id WHERE (movement.delivered=1 or movement.delivered is NULL);';
    final result = await db.rawQuery(query);
    return result.map((json) => DoorModel.fromJson(json)).toList();
  }

  Future<int> update(DoorModel doorSize) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      DoorSizeFields.tableName,
      doorSize.toJson(),
      where: '${DoorSizeFields.id} = ?',
      whereArgs: [doorSize.doorId],
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
  static const String tableName = 'door';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
