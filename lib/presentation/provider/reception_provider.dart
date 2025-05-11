import 'package:flutter/material.dart';
import 'package:locker_app/infrastructure/locker_model.dart';
import 'package:locker_app/repositories/locker_repository.dart';
import 'package:locker_app/infrastructure/user_model.dart';
import 'package:locker_app/repositories/users_migration.dart';
import 'package:locker_app/services/movement_service.dart';

class ReceptionProvider extends ChangeNotifier {
  final UserService userService = UserService();
  final userRepository = UserRepository();
  final lockerRepository = LockerRepository();

  List<UserModel> userList = [];
  List<LockerModel> lockerList = [];

  Future<void> sendMovement(String text) async {}

  Future<void> getListUsers() async {
    final users = await userRepository.readAll();
    userList = users;

    notifyListeners();
  }

  Future<void> getListLockers() async {
    final lockers = await lockerRepository.readAll();
    lockerList = lockers;

    notifyListeners();
  }
}
