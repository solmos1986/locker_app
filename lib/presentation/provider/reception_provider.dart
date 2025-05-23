import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:locker_app/domain/entities/user_entity.dart';
import 'package:locker_app/repositories/users_migration.dart';

class ReceptionProvider extends ChangeNotifier {
  final userRepository = UserRepository();

  List<UserEntity> userList = [];

  Future<void> sendMovement(String text) async {}

  Future<void> getListUsers() async {
    final users = await userRepository.readAll();

    userList = users;
    //notifyListeners();
  }
}
