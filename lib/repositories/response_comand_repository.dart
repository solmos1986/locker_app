import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/response_comand_entity.dart';

class ResponseComandRepository {
  Future<int> createAll(List<ResponseComandEntity> movements) async {
    int count = 0;
    for (var movement in movements) {
      await create(movement);
      count++;
    }
    return count;
  }

  Future<ResponseComandEntity> create(ResponseComandEntity client) async {
    final db = await LockeAppDatabase.instance.database;
    final id = await db.insert(ClientFields.tableName, client.toJson());
    return client.copy(responseComandId: id);
  }

  /* Future<void> createMovement(int userId, int doorId, String code) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery(
      "INSERT INTO response_comand (user_id,door_id,code) VALUES(?,?,?);",
      [userId, doorId, code],
    );
  } */

  Future<void> updateMovement(int movementId) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery(
      "UPDATE response_comand set delivered = 1 WHERE response_comand.response_comand_id = ?",
      [movementId],
    );
  }

  Future<ResponseComandEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      ClientFields.tableName,
      columns: columns,
      where: '${ClientFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ResponseComandEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ResponseComandEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(ClientFields.tableName, orderBy: orderBy);
    return result.map((json) => ResponseComandEntity.fromJson(json)).toList();
  }

  /* Future<List<VerifiedCodeModel>> verifiedCode(String code) async {
    final db = await LockeAppDatabase.instance.database;
    String query =
        "SELECT door.number, door_size.name, movement.movement_id, movement.create_at, movement.code FROM movement INNER JOIN door on door.door_id=movement.door_id INNER JOIN door_size on door_size.door_size_id=door.door_size_id WHERE movement.code='${code.toString()}' and movement.delivered=0";
    final result = await db.rawQuery(query);
    return result.map((json) => VerifiedCodeModel.fromJson(json)).toList();
  } */

  Future<int> update(ResponseComandEntity requestComand) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      ClientFields.tableName,
      requestComand.toJson(),
      where: '${ClientFields.id} = ?',
      whereArgs: [requestComand.responseComandId],
    );
  }

  Future<int> delete(int id) async {
    final db = await LockeAppDatabase.instance.database;
    return await db.delete(
      ClientFields.tableName,
      where: '${ClientFields.id} = ?',
      whereArgs: [id],
    );
  }
}

class ClientFields {
  static const String tableName = 'response_comand';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
