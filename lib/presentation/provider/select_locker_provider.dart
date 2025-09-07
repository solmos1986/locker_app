import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_serial/flutter_serial.dart';
import 'package:locker_app/helper/door_available.dart';
import 'package:locker_app/repositories/door_repository.dart';
import 'package:locker_app/repositories/request_comand_repository.dart';
import 'package:locker_app/services/integration/connect_serial.dart';
import 'package:locker_app/utils/detect_stream.dart';
import 'package:locker_app/utils/get_log_reponse.dart';

class SelectLockerProvider extends ChangeNotifier {
  SelectLockerProvider() {
    getListAvailableDoors();
  }
  final detectStream = DetectStream();
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

    connectSerial.getListenSerial().take(1).listen((SerialResponse? result) async {
      final value = getLogReponse.getLogsResponse(result!.readChannel!);
      if (value == comands.first.responseComand) {
        isValid = true;
        notifyListeners();
      }
    });
    
    //test
    isValid = true;
    notifyListeners();

    connectSerial.sendMessage(comands.first.requestComand);
  }

  Future<void> retry(DoorAvailable door) async {
    isValid = false;
    notifyListeners();
    await openDoor(door);
  }
}
