import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/services/movement_service.dart';

class ConfirmReceptionProvider extends ChangeNotifier {
  final movementRepository = MovementRepository();
  final serviceRepository = MovementService();

  bool valid = false;
  String message = 'Presione abrir casillero';

  ConfirmReceptionProvider() {
    log("init");
    //updateMovement();
  }

  Future<void> updateMovement(int movementId) async {
    await movementRepository.updateMovement(movementId);
    valid = true;
    message = 'No olvide cerrar el casillero';
    try {
      await serviceRepository.updateMovement(movementId);
    } catch (e) {
      log("error en la conexion");
    }
    notifyListeners();
  }
  
}
