import 'dart:developer';

import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/door_entity.dart';
import 'package:locker_app/domain/entities/door_total.dart';

class DoorRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<DoorEntity> doors) async {
    int count = 0;
    for (var door in doors) {
      await create(door);
      count++;
    }
    return count;
  }

  Future<DoorEntity> create(DoorEntity door) async {
    final query = await db.database;
    final id = await query.insert(DoorSizeFields.tableName, door.toJson());
    return door.copy(doorId: id);
  }

  Future<List<DoorEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' locker_id DESC';
    final result = await db.query(DoorSizeFields.tableName, orderBy: orderBy);
    return result.map((json) => DoorEntity.fromJson(json)).toList();
  }

  Future<DoorEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      DoorSizeFields.tableName,
      columns: columns,
      where: '${DoorSizeFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DoorEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DoorTotalModel>> readDoorAvailable(int doorSizeId) async {
    final db = await LockeAppDatabase.instance.database;
    String query =
        "SELECT door.number, door.door_id, door_size.name FROM door INNER JOIN door_size on door.door_size_id = door_size.door_size_id LEFT JOIN movement on movement.door_id = door.door_id WHERE ( movement.delivered is NULL or movement.delivered > 0 ) and door_size.door_size_id=${doorSizeId.toString()};";
    final result = await db.rawQuery(query);
    log('query readDoorAvailable ');
    return result.map((json) => DoorTotalModel.fromJson(json)).toList();
  }

  Future<int> update(DoorEntity doorSize) async {
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
