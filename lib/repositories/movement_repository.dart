import 'package:locker_app/config/database.dart';
import 'package:locker_app/infrastructure/movement_model.dart';

class MovementRepository {
  Future<int> createAll(List<MovementModel> movements) async {
    int count = 0;
    for (var movement in movements) {
      await create(movement);
      count++;
    }
    return count;
  }

  Future<MovementModel> create(MovementModel client) async {
    final db = await LockeAppDatabase.instance.database;
    final id = await db.insert(ClientFields.tableName, client.toJson());
    return client.copy(movementId: id);
  }

  Future<void> createMovement(int doorId, String code) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery("INSERT INTO movement (door_id,code) VALUES(?,?);", [
      doorId,
      code,
    ]);
  }

  Future<MovementModel> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      ClientFields.tableName,
      columns: columns,
      where: '${ClientFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return MovementModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<MovementModel>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(ClientFields.tableName, orderBy: orderBy);
    return result.map((json) => MovementModel.fromJson(json)).toList();
  }

  Future<int> update(MovementModel movement) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      ClientFields.tableName,
      movement.toJson(),
      where: '${ClientFields.id} = ?',
      whereArgs: [movement.movementId],
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
  static const String tableName = 'movement';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
