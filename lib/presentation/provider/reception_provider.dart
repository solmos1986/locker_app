
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/domain/entities/departament_entity.dart';
import 'package:locker_app/repositories/department_repository.dart';

class ReceptionProvider extends ChangeNotifier {
  final departmentRepository = DepartmentRepository();

  ReceptionProvider() {
    getListUsers();
  }

  List<DepartmentEntity> userList = [];

  Future<void> sendMovement(String text) async {}

  Future<void> getListUsers() async {
    final departament = await departmentRepository.readAll();
    log("departament ${departament.length}");
    userList = departament;
    notifyListeners();
  }
}
