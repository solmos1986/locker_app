import 'package:locker_app/config/database.dart';
import 'package:locker_app/infrastructure/controller_model.dart';

class ControllerRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<ControllerModel> controllers) async {
    int count = 0;
    for (var controller in controllers) {
      await create(controller);
      count++;
    }
    return count;
  }

  Future<ControllerModel> create(ControllerModel controller) async {
    final query = await db.database;
    final id = await query.insert(ClientFields.tableName, controller.toJson());
    return controller.copy(controllerId: id);
  }

  Future<ControllerModel> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      ClientFields.tableName,
      columns: columns,
      where: '${ClientFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ControllerModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ControllerModel>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(ClientFields.tableName, orderBy: orderBy);
    return result.map((json) => ControllerModel.fromJson(json)).toList();
  }

  Future<int> update(ControllerModel client) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      ClientFields.tableName,
      client.toJson(),
      where: '${ClientFields.id} = ?',
      whereArgs: [client.controllerId],
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
  static const String tableName = 'controller';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
