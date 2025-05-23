import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/movement_entity.dart';

class MovementRepository {
  Future<int> createAll(List<MovementEntity> movements) async {
    int count = 0;
    for (var movement in movements) {
      await create(movement);
      count++;
    }
    return count;
  }

  Future<MovementEntity> create(MovementEntity client) async {
    final db = await LockeAppDatabase.instance.database;
    final id = await db.insert(ClientFields.tableName, client.toJson());
    return client.copy(movementId: id);
  }

  Future<void> createMovement(int userId,int doorId, String code) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery("INSERT INTO movement (user_id,door_id,code) VALUES(?,?,?);", [
      userId,
      doorId,
      code,
    ]);
  }

  Future<MovementEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      ClientFields.tableName,
      columns: columns,
      where: '${ClientFields.id} = ?',
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
    final result = await db.query(ClientFields.tableName, orderBy: orderBy);
    return result.map((json) => MovementEntity.fromJson(json)).toList();
  }

  Future<int> update(MovementEntity movement) async {
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
