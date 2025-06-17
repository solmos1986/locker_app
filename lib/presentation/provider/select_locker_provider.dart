import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/helper/door_available.dart';
import 'package:locker_app/repositories/door_repository.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/integration/connect_serial.dart';
import 'package:locker_app/utils/get_log_reponse.dart';

class SelectLockerProvider extends ChangeNotifier {
  SelectLockerProvider() {
    getListAvailableDoors();
  }
  final getLogReponse = GetLogReponse();
  final connectSerial = ConnectSerial();
  final doorRepository = DoorRepository();
  final requestComandRepository = RequestComandRepository();
  //props
  bool isValid = false;

  DoorAvailable doorSmall = DoorAvailable(
    name: 'Pequeño',
    number: 0,
    doorId: 0,
    total: 0,
  );
  DoorAvailable doorMedium = DoorAvailable(
    name: 'Mediano',
    number: 0,
    doorId: 0,
    total: 0,
  );
  DoorAvailable doorBig = DoorAvailable(
    name: 'Grande',
    number: 0,
    doorId: 0,
    total: 0,
  );

  Future<void> getListAvailableDoors() async {
    final queryDoorSmall = await doorRepository.readDoorAvailable(1);
    final queryDoorMedium = await doorRepository.readDoorAvailable(2);
    final queryDoorBig = await doorRepository.readDoorAvailable(3);

    if (queryDoorSmall.isNotEmpty) {
      doorSmall.number = queryDoorSmall.first.number;
      doorSmall.name = queryDoorSmall.first.name;
      doorSmall.doorId = queryDoorSmall.first.doorId;
      doorSmall.total = queryDoorSmall.length;
    }

    if (queryDoorMedium.isNotEmpty) {
      doorMedium.number = queryDoorMedium.first.number;
      doorMedium.name = queryDoorMedium.first.name;
      doorMedium.doorId = queryDoorMedium.first.doorId;
      doorMedium.total = queryDoorMedium.length;
    }

    if (queryDoorBig.isNotEmpty) {
      doorBig.number = queryDoorBig.first.number;
      doorBig.name = queryDoorBig.first.name;
      doorBig.doorId = queryDoorBig.first.doorId;
      doorBig.total = queryDoorBig.length;
    }
    notifyListeners();
  }

  Future<void> openDoor(DoorAvailable door) async {
    log('openDoor del casillero ${door.doorId}');

    final comands = await requestComandRepository.getCodeForDoor(
      door.doorId,
      "abrir",
    );

    connectSerial.getListenSerial().listen((SerialResponse? result) async {
      final value = getLogReponse.getLogsResponse(result!.readChannel!);
      log('codigo leido => $value');
      log('comparar => $value y ${comands.first.responseComand}');
      if (value == comands.first.responseComand) {
        log('abrio puerta');
        isValid = true;
        log('isValid ${isValid.toString()}');
        notifyListeners();
        //destruir la conexion
        //await connectSerial.closePort();
      }
    });

    log('enviar code => ${comands.first.requestComand}');
    connectSerial.setMessage(comands.first.requestComand);

    /* connectSerial.getListenSerialFake().listen((int result) {
      log('leendo getListenSerialFake  => $result');
      if (result == 3) {
        isValid = true;
        notifyListeners();
      }
    }); */
  }
}
