import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/repositories/movement_repository.dart';

class VerifiedCodeProvider extends ChangeNotifier {
  final movementRepository = MovementRepository();
  bool isValid = false;
  String codeQR = '';
  VerifiedCodeModel movement = VerifiedCodeModel(
    doorId: -1,
    code: '',
    movementId: -1,
    numberDoor: -1,
    nameSizeDoor: '',
    createAt: DateTime.now(),
  );

  VerifiedCodeProvider() {
    log('init class VerifiedCodeProvider');
    codeQR = '';
  }

  Future<void> detectCodeQr(String code) async {
    codeQR += code.replaceAll('null', '');
    if (codeQR.contains('\n')) {
      await verifiedCode(codeQR);
      log('codigo acumulado $codeQR');
      notifyListeners();
    }
  }

  Future<void> verifiedCode(String code) async {
    final result = await movementRepository.verifiedCode(code);
    if (result.isEmpty) {
      isValid = false;
    } else {
      isValid = true;
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
    isValid = true;
    notifyListeners();
  }
}
