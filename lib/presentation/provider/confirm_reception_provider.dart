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
  final movementService = MovementService();
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
      log('${value} == ${comands.first.responseComand} ');
      if (value == comands.first.responseComand) {
        isValid = true;
        notifyListeners();
      } else {
        isValid = false;
        notifyListeners();
      }
    });
    //Stream data=connectSerial.getListenSerial().last;
    log("ConfirmReceptionProvider updateMovement");
    connectSerial.sendMessage(comands.first.requestComand);
    message = 'No olvide cerrar el casillero';
    //notifyListeners();
  }

  Future<void> retry(VerifiedCodeModel verifiedCodeModel) async {
    isValid = false;
    notifyListeners();
    await updateMovement(verifiedCodeModel);
  }

  Future<void> confirmeReception(VerifiedCodeModel verifiedCodeModel) async {
    log(
      'MODIFCANDO MOVIMIENTO A SQLITE movementId ${verifiedCodeModel.movementId}',
    );
    log('MODIFCANDO MOVIMIENTO A SQLITE doorId ${verifiedCodeModel.doorId}');
    log('MODIFCANDO MOVIMIENTO A SQLITE idRef ${verifiedCodeModel.idRef}');
    log(
      'MODIFCANDO MOVIMIENTO A SQLITE departmentId ${verifiedCodeModel.departmentId}',
    );
    log(
      'MODIFCANDO MOVIMIENTO A SQLITE nameDoor ${verifiedCodeModel.nameDoor}',
    );
    log(
      'MODIFCANDO MOVIMIENTO A SQLITE nameSizeDoor ${verifiedCodeModel.nameSizeDoor}',
    );
    await movementRepository.updateDoorForMovement(1, verifiedCodeModel.doorId);
    await movementRepository.receivedMovement(
      verifiedCodeModel.departmentId,
      verifiedCodeModel.doorId,
      verifiedCodeModel.code,
      verifiedCodeModel.idRef,
    );
    log('MODIFCANDO MOVIMIENTO A WEB SERVER');
    try {
      await movementService.updateMovement(
        verifiedCodeModel.departmentId,
        verifiedCodeModel.doorId,
        verifiedCodeModel.code,
        verifiedCodeModel.idRef,
      );
    } catch (e) {
      log('ERROR AL ENVIAR AL SERVER');
    }
  }
}
