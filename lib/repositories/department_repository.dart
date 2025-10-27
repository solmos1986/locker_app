import 'package:locker_app/config/database.dart';
import 'package:locker_app/domain/entities/departament_entity.dart';

class DepartmentRepository {
  final db = LockeAppDatabase.instance;

  Future<int> createAll(List<DepartmentEntity> departaments) async {
    int count = 0;
    for (var departament in departaments) {
      await create(departament);
      count++;
    }
    return count;
  }

  Future<DepartmentEntity> create(DepartmentEntity departament) async {
    final query = await db.database;
    final id = await query.insert(DepartmentFields.tableName, departament.toJson());
    return departament.copy(departmentId: id);
  }

  Future<DepartmentEntity> read(int id) async {
    final db = await LockeAppDatabase.instance.database;

    List<String>? columns = ['department_id', 'building_id', 'name', 'state'];

    final maps = await db.query(
      DepartmentFields.tableName,
      columns: columns,
      where: '${DepartmentFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DepartmentEntity.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<DepartmentEntity>> readAll() async {
    final db = await LockeAppDatabase.instance.database;
    const orderBy = ' department_id ASC';
    final result = await db.query(DepartmentFields.tableName, orderBy: orderBy);
    return result.map((json) => DepartmentEntity.fromJson(json)).toList();
  }

  Future<int> update(DepartmentEntity departament) async {
    final db = await LockeAppDatabase.instance.database;
    return db.update(
      DepartmentFields.tableName,
      departament.toJson(),
      where: '${DepartmentFields.id} = ?',
      whereArgs: [departament.departmentId],
    );
  }

  Future<int> delete(int id) async {
    final db = await LockeAppDatabase.instance.database;
    return await db.delete(
      DepartmentFields.tableName,
      where: '${DepartmentFields.id} = ?',
      whereArgs: [id],
    );
  }
}

class DepartmentFields {
  static const String tableName = 'department';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
