import 'package:flutter/foundation.dart';
import 'package:locker_app/config/database.dart';
import 'package:locker_app/repositories/reset_repositoty.dart';
import 'package:locker_app/repositories/locker_repository.dart';
import 'package:locker_app/repositories/users_migration.dart';
import 'package:locker_app/services/database_service.dart';

class ConfigProvider extends ChangeNotifier {
  final dataBaseService = DatabaseService();
  final lockeAppDatabase = LockeAppDatabase.instance;
  final resetRepository = ResetRepository();
  final userRepository = UserRepository();
  final lockerRepository = LockerRepository();

  bool load = false;

  Future<void> inizializeDataBase() async {
    await resetRepository.inizializeDataBase();
  }

  Future<void> getDataBase() async {
    load = true;
    notifyListeners();
    final fecthDatabase = await dataBaseService.getAllDataBase();
    await resetRepository.resetDataBase();

    await userRepository.createAll(fecthDatabase.users);
    await lockerRepository.createAll(fecthDatabase.lockers);
    load = false;
    notifyListeners();
  }
}
