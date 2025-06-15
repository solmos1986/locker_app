import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/movement_service.dart';

class ConfirmReceptionProvider extends ChangeNotifier {
  final movementRepository = MovementRepository();
  final requestComandRepository = RequestComandRepository();
  final serviceRepository = MovementService();

  bool valid = false;
  String message = 'Presione abrir casillero';

  ConfirmReceptionProvider() {
    //updateMovement();
  }

  Future<void> updateMovement(VerifiedCodeModel verifiedCodeModel) async {
    log("ConfirmReceptionProvider updateMovement");
    final comands = await requestComandRepository.getCodeForDoor(
      verifiedCodeModel.doorId,
      "abrir",
    );
    log('enviar code => ${comands.first.requestComand}');

    
    //await movementRepository.updateMovement(movementId);
    valid = true;
    message = 'No olvide cerrar el casillero';
    try {
      //await serviceRepository.updateMovement(movementId);
    } catch (e) {
      log("error en la conexion");
    }
    notifyListeners();
  }
}
