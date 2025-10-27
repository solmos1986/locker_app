import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/movement_entity.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';

class MovementRepository {


  Future<int> createAll(List<MovementEntity> movements) async {
    int count = 0;
    for (var movement in movements) {
      await create(movement);
      count++;
    }
    return count;
  }

  Future<MovementEntity> create(MovementEntity moment) async {
    final db = await LockeAppDatabase.instance.database;
    final id = await db.insert(MovementFields.tableName, moment.toJson());
    return moment.copy(movementId: id);
  }

  Future<void> updateDoorForMovement(int state, int doorId) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery("UPDATE door set state = ? WHERE door.door_id = ?", [
      state,
      doorId,
    ]);
  }

  Future<void> pendingMovement(int departmentId, int doorId, String code, String idRef) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery(
      "INSERT INTO movement (user_id, door_id, code, building_id, type_movement_id, id_ref) VALUES(?, ?, ?, ?, ?, ?);",
      [departmentId, doorId, code, EnvConfig.buildingId, 1, idRef],
    );
  }

  Future<void> receivedMovement(int departmentId, int doorId, String code, String idRef) async {
    final db = await LockeAppDatabase.instance.database;
     await db.rawQuery(
      "INSERT INTO movement (user_id, door_id, code, building_id, type_movement_id, id_ref) VALUES(?, ?, ?, ?, ?, ?);",
      [departmentId, doorId, code, EnvConfig.buildingId, 2, idRef],
    );
  }

  Future<MovementEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      MovementFields.tableName,
      columns: columns,
      where: '${MovementFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MovementEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MovementEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(MovementFields.tableName, orderBy: orderBy);
    return result.map((json) => MovementEntity.fromJson(json)).toList();
  }

  Future<List<VerifiedCodeModel>> verifiedCode(String code) async {
    final db = await LockeAppDatabase.instance.database;
    String query =
        "SELECT door.door_id, movement.department_id, movement.id_ref, door.name, door_size.name, movement.movement_id, movement.create_at, movement.code, movement.id_ref FROM movement INNER JOIN door on door.door_id=movement.door_id INNER JOIN door_size on door_size.door_size_id=door.door_size_id WHERE movement.code='${code.toString()}' and movement.type_movement_id=1";
    final result = await db.rawQuery(query);
    return result.map((json) => VerifiedCodeModel.fromJson(json)).toList();
  }

  Future<int> update(MovementEntity movement) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      MovementFields.tableName,
      movement.toJson(),
      where: '${MovementFields.id} = ?',
      whereArgs: [movement.movementId],
    );
  }

  Future<int> delete(int id) async {
    final db = await LockeAppDatabase.instance.database;
    return await db.delete(
      MovementFields.tableName,
      where: '${MovementFields.id} = ?',
      whereArgs: [id],
    );
  }
}

class MovementFields {
  static const String tableName = 'movement';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
