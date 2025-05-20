import 'package:flutter/material.dart';
import 'package:locker_app/infrastructure/door_model.dart';
import 'package:locker_app/repositories/door_repository.dart';
import 'package:locker_app/repositories/locker_repository.dart';
import 'package:locker_app/infrastructure/user_model.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/services/movement_service.dart';

class MovementProvider extends ChangeNotifier {
  final movementService = MovementService();

  final movementRepository = MovementRepository();
  final lockerRepository = LockerRepository();
  final doorRepository = DoorRepository();

  List<UserModel> userList = [];
  List<DoorModel> doorList = [];

  Future<void> sendMovement(int doorId) async {
    DateTime now = DateTime.now();
    String code =
        now.year.toString() +
        now.month.toString() +
        now.day.toString() +
        now.hour.toString() +
        now.minute.toString() +
        now.second.toString();

    await movementRepository.createMovement(doorId, code);

    final status = await movementService.storeMovement(doorId, code);
    if (status.status == "ok") {
      notifyListeners();
    } else {}
  }

  Future<void> getListDoors() async {
    final doors = await doorRepository.readDoorAvailable();
    doorList = doors;

    notifyListeners();
  }
}
