import 'dart:developer';

import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/request_comand_entity.dart';
import 'package:locker_app/infrastructure/models/get_code_door_model.dart';

class RequestComandRepository {
  Future<int> createAll(List<RequestComandEntity> movements) async {
    int count = 0;
    for (var movement in movements) {
      await create(movement);
      count++;
    }
    return count;
  }

  Future<RequestComandEntity> create(RequestComandEntity client) async {
    final db = await LockeAppDatabase.instance.database;
    final id = await db.insert(ClientFields.tableName, client.toJson());
    return client.copy(requestComandId: id);
  }

  Future<void> updateMovement(int movementId) async {
    final db = await LockeAppDatabase.instance.database;
    await db.rawQuery(
      "UPDATE movement set delivered = 1 WHERE movement.movement_id = ?",
      [movementId],
    );
  }

  Future<RequestComandEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      ClientFields.tableName,
      columns: columns,
      where: '${ClientFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RequestComandEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<RequestComandEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(ClientFields.tableName, orderBy: orderBy);
    return result.map((json) => RequestComandEntity.fromJson(json)).toList();
  }

  Future<int> update(RequestComandEntity requestComand) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      ClientFields.tableName,
      requestComand.toJson(),
      where: '${ClientFields.id} = ?',
      whereArgs: [requestComand.requestComandId],
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

  Future<List<GetCodeDoorModel>> getCodeForDoor(
    int doorId,
    String action,
  ) async {
    final db = await LockeAppDatabase.instance.database;

    String query =
        "SELECT request_comand.comand as request_comand, response_comand.name as name_request, response_comand.comand as response_comand, response_comand.name as name_response FROM request_comand INNER JOIN door on door.door_id=request_comand.door_id INNER JOIN response_comand on response_comand.request_comand_id=request_comand.request_comand_id where door.door_id=? and request_comand.name=? ;";
    final result = await db.rawQuery(query, [doorId, action]);
    //log('query readDoorAvailable para tamaño ${result.toString()}');
    return result.map((json) => GetCodeDoorModel.fromJson(json)).toList();
  }
}

class ClientFields {
  static const String tableName = 'request_comand';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
