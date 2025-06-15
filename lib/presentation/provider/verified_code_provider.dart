import 'package:flutter/material.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/repositories/movement_repository.dart';

class VerifiedCodeProvider extends ChangeNotifier {
  final movementRepository = MovementRepository();
  bool valid = false;

  VerifiedCodeModel movement = VerifiedCodeModel(
    doorId: -1,
    code: '',
    movementId: -1,
    numberDoor: -1,
    nameSizeDoor: '',
    createAt: DateTime.now(),
  );

  VerifiedCodeProvider() {
    //getListUsers();
  }

  Future<void> verifiedCode(String code) async {
    final result = await movementRepository.verifiedCode(code);
    if (result.isEmpty) {
      valid = false;
    } else {
      valid = true;
      movement.doorId = result.first.doorId;
      movement.code = result.first.code;
      movement.movementId = result.first.movementId;
      movement.nameSizeDoor = result.first.nameSizeDoor;
      movement.numberDoor = result.first.numberDoor;
      movement.createAt = result.first.createAt;
    }
    notifyListeners();
  }

  Future<void> updateMovement(int movementId) async {
    await movementRepository.updateMovement(movementId);
    valid = true;
    notifyListeners();
  }
}
