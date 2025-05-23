import 'dart:developer';

import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/user_entity.dart';

class UserRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<UserEntity> users) async {
    int count = 0;
    for (var user in users) {
      await create(user);
      count++;
    }
    return count;
  }

  Future<UserEntity> create(UserEntity user) async {
    final query = await db.database;
    final id = await query.insert(UsersFields.tableName, user.toJson());
    return user.copy(userId: id);
  }

  Future<UserEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['id', 'client_id', 'name', 'state'];

    final maps = await db.query(
      UsersFields.tableName,
      columns: columns,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return UserEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<UserEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' user_id ASC';
    final result = await db.query(UsersFields.tableName, orderBy: orderBy);
    log("readAll user sqlite");
    return result.map((json) => UserEntity.fromJson(json)).toList();
  }

  Future<int> update(UserEntity user) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      UsersFields.tableName,
      user.toJson(),
      where: '${UsersFields.id} = ?',
      whereArgs: [user.userId],
    );
  }

  Future<int> delete(int id) async {
    final db = await LockeAppDatabase.instance.database;
    return await db.delete(
      UsersFields.tableName,
      where: '${UsersFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<void> resetDataBase() async {
    final query = await db.database;
    return await query.execute('''
        DELETE from users;
        DELETE from lockers;
     ''');
  }
}

class UsersFields {
  static const String tableName = 'user';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
