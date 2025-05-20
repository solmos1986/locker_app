import 'package:flutter/material.dart';
import 'package:locker_app/infrastructure/door_model.dart';
import 'package:locker_app/repositories/door_repository.dart';
import 'package:locker_app/repositories/locker_repository.dart';
import 'package:locker_app/infrastructure/user_model.dart';
import 'package:locker_app/repositories/users_migration.dart';

class ReceptionProvider extends ChangeNotifier {
  final userRepository = UserRepository();
  final lockerRepository = LockerRepository();
  final doorRepository = DoorRepository();

  List<UserModel> userList = [];
  List<DoorModel> doorList = [];

  Future<void> sendMovement(String text) async {}

  Future<void> getListUsers() async {
    final users = await userRepository.readAll();
    userList = users;

    notifyListeners();
  }

  Future<void> getListDoors() async {
    final doors = await doorRepository.readDoorAvailable();
    doorList = doors;

    notifyListeners();
  }
}
