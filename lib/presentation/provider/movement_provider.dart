import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/domain/entities/door_entity.dart';
import 'package:locker_app/infrastructure/models/movement_model.dart';
import 'package:locker_app/domain/entities/user_entity.dart';
import 'package:locker_app/repositories/movement_repository.dart';
import 'package:locker_app/services/movement_service.dart';
import 'package:locker_app/utils/generate_code.dart';

class MovementProvider extends ChangeNotifier {
  final movementService = MovementService();

  final movementRepository = MovementRepository();

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
    log('verifiedCloseDoor verificar casillero ${movement.doorId}');
    notifyListeners();
  }
}
