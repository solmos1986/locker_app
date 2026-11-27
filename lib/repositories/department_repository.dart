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
    final departments =
        result.map((json) => DepartmentEntity.fromJson(json)).toList();
    departments.sort((a, b) => compareDepartmentNames(a.name, b.name));
    return departments;
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

final _numeroInicial = RegExp(r'^\s*(\d+)');

/// Orden natural de nombres de departamento: primero los que empiezan por
/// número, de menor a mayor (1, 2, 100, 950), y luego los que empiezan por
/// letra, de la A a la Z sin distinguir mayúsculas.
int compareDepartmentNames(String a, String b) {
  final numA = _numeroInicial.firstMatch(a);
  final numB = _numeroInicial.firstMatch(b);

  if (numA != null && numB != null) {
    final cmp = BigInt.parse(numA.group(1)!).compareTo(BigInt.parse(numB.group(1)!));
    if (cmp != 0) return cmp;
  } else if (numA != null) {
    return -1;
  } else if (numB != null) {
    return 1;
  }
  return a.trim().toLowerCase().compareTo(b.trim().toLowerCase());
}

class DepartmentFields {
  static const String tableName = 'department';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String id = '_id';
}
