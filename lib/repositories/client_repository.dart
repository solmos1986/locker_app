import 'package:locker_app/config/database.dart';
import 'package:locker_app/infrastructure/cliente_model.dart';

class ClientRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<ClientModel> clients) async {
    int count = 0;
    for (var client in clients) {
      await create(client);
      count++;
    }
    return count;
  }

  Future<ClientModel> create(ClientModel client) async {
    final query = await db.database;
    final id = await query.insert(ClientFields.tableName, client.toJson());
    return client.copy(clientId: id);
  }

  Future<ClientModel> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'lockerId', 'name', 'state'];

    final maps = await db.query(
      ClientFields.tableName,
      columns: columns,
      where: '${ClientFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ClientModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ClientModel>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' id DESC';
    final result = await db.query(ClientFields.tableName, orderBy: orderBy);
    return result.map((json) => ClientModel.fromJson(json)).toList();
  }

  Future<int> update(ClientModel client) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      ClientFields.tableName,
      client.toJson(),
      where: '${ClientFields.id} = ?',
      whereArgs: [client.clientId],
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
  static const String tableName = 'client';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
