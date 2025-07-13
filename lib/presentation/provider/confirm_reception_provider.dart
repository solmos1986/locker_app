import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/infrastructure/models/verified_code_model.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/integration/connect_serial.dart';
import 'package:locker_app/services/movement_service.dart';
import 'package:locker_app/utils/get_log_reponse.dart';

class ConfirmReceptionProvider extends ChangeNotifier {
  final movementRepository = MovementRepository();
  final requestComandRepository = RequestComandRepository();
  final serviceRepository = MovementService();
  final connectSerial = ConnectSerial();
  final getLogReponse = GetLogReponse();

  bool isValid = false;
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

    connectSerial.getListenSerial().listen((SerialResponse? result) async {
      final value = getLogReponse.getLogsResponse(result!.readChannel!);
      if (value == comands.first.responseComand) {
        isValid = true;
        notifyListeners();
      }
    });
    
    connectSerial.sendMessage(comands.first.requestComand);
    await movementRepository.updateMovement(verifiedCodeModel.movementId);

    message = 'No olvide cerrar el casillero';
    try {
      await serviceRepository.updateMovement(verifiedCodeModel.movementId);
    } catch (e) {
      log("error en la conexion");
    }
    notifyListeners();
  }

  Future<void> retry(VerifiedCodeModel verifiedCodeModel) async {
    isValid = false;
    notifyListeners();
    await updateMovement(verifiedCodeModel);
  }
}
