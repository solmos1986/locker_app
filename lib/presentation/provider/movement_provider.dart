import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/domain/entities/door_entity.dart';
import 'package:locker_app/infrastructure/models/movement_model.dart';
import 'package:locker_app/domain/entities/user_entity.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/integration/connect_serial.dart';
import 'package:locker_app/services/movement_service.dart';
import 'package:locker_app/utils/detect_stream.dart';
import 'package:locker_app/utils/generate_code.dart';
import 'package:locker_app/utils/get_log_reponse.dart';
import 'package:locker_app/utils/sonido.dart';

class MovementProvider extends ChangeNotifier {
  final sonido = Sonido();
  final detectStream = DetectStream();
  final getLogReponse = GetLogReponse();
  final movementService = MovementService();
  final connectSerial = ConnectSerial();
  final movementRepository = MovementRepository();
  final requestComandRepository = RequestComandRepository();
  //PROPS
  bool isValid = false;
  List<UserEntity> userList = [];
  List<DoorEntity> doorList = [];

  Future<void> sendMovement(MovementModel movement) async {
    final generateCode = GenerateCode();
    var code = generateCode.generateCode(movement.nameUser);

    await movementRepository.createMovement(
      movement.userId,
      movement.doorId,
      code,
    );

    notifyListeners();

    try {
      final status = await movementService.storeMovement(
        movement.userId,
        movement.doorId,
        code,
      );
      if (status.status == "ok") {}
    } catch (e) {
      log('Error en la api');
    }
  }

  Future<void> verifiedCloseDoor(MovementModel movement) async {
    log('MovementProvider verifiedCloseDoor ${movement.doorId}');

    final comands = await requestComandRepository.getCodeForDoor(
      movement.doorId,
      "lectura",
    );
    final open = comands[1].responseComand;
    final close = comands[0].responseComand;
    log('codigo abierto  => $open    cerrado => $close');
    /*  isValid = true;
    notifyListeners(); */
    connectSerial.getListenSerial().listen((SerialResponse? result) async {
      final value = getLogReponse.getLogsResponse(result!.readChannel!);
      log('comparar => $value y $close');
      if (value == close) {
        log('esta cerrada');

        isValid = true;
        notifyListeners();
        //enviar pedido
        //await sendMovement(movement);
      } else {
        log('no esta cerrada');
        isValid = false;
        notifyListeners();
      }
    });

    connectSerial.sendMessage(comands.first.requestComand);
    notifyListeners();
  }

  Future<void> retry(MovementModel movement) async {
    isValid = false;
    notifyListeners();
    await verifiedCloseDoor(movement);
  }
}
