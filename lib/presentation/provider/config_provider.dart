import 'package:flutter/foundation.dart';
import 'package:locker_app/config/database.dart';
import 'package:locker_app/repositories/department_repository.dart';
import 'package:locker_app/repositories/controller_repository.dart';
import 'package:locker_app/repositories/door_repository.dart';
import 'package:locker_app/repositories/door_size_repository.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/repositories/reset_repository.dart';
import 'package:locker_app/repositories/locker_repository.dart';
import 'package:locker_app/repositories/response_comand_repository.dart';
import 'package:locker_app/repositories/users_migration.dart';
import 'package:locker_app/services/database_service.dart';

class ConfigProvider extends ChangeNotifier {
  final dataBaseService = DatabaseService();
  final lockeAppDatabase = LockeAppDatabase.instance;
  final resetRepository = ResetRepository();
  final departmentRepository = DepartmentRepository();
  final userRepository = UserRepository();
  final lockerRepository = LockerRepository();
  final controllerRepository = ControllerRepository();
  final doorSizeRepository = DoorSizeRepository();
  final doorRepository = DoorRepository();
  final movementRepository = MovementRepository();
  final requestComandRepository = RequestComandRepository();
  final responseComandRepository = ResponseComandRepository();
  bool load = false;

  Future<void> inizializeDataBase() async {
    await resetRepository.inizializeDataBase();
  }

  Future<void> getDataBase() async {
    load = true;
    notifyListeners();
    final fecthDatabase = await dataBaseService.getAllDataBase();
    await resetRepository.resetDataBase();

    await departmentRepository.createAll(fecthDatabase.departments);
    await lockerRepository.createAll(fecthDatabase.lockers);
    //await userRepository.createAll(fecthDatabase.users);
    await controllerRepository.createAll(fecthDatabase.controllers);
    await doorSizeRepository.createAll(fecthDatabase.doorSizes);
    await doorRepository.createAll(fecthDatabase.doors);
    await movementRepository.createAll(fecthDatabase.movements);
    await requestComandRepository.createAll(fecthDatabase.requestComand);
    await responseComandRepository.createAll(fecthDatabase.responseComand);

    load = false;
    notifyListeners();
  }
}
