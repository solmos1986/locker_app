import 'package:locker_app/config/database.dart';

class ResetRepository {
  final db = LockeAppDatabase.instance;

  Future<void> inizializeDataBase() async {
    await LockeAppDatabase.instance.database;
  }

  Future<void> resetDataBase() async {
    final query = await db.database;
    await query.execute('''
        DELETE from users;
     ''');

    await query.execute('''
        DELETE from lockers;
     ''');
  }
}
