import 'package:dio/dio.dart';
import 'package:locker_app/domain/entities/departament_entity.dart';
import 'package:locker_app/domain/entities/controller_entity.dart';
import 'package:locker_app/domain/entities/door_entity.dart';
import 'package:locker_app/domain/entities/door_size_entity.dart';
import 'package:locker_app/domain/entities/locker_entity.dart';
import 'package:locker_app/domain/entities/movement_entity.dart';
import 'package:locker_app/domain/entities/request_comand_entity.dart';
import 'package:locker_app/domain/entities/response_comand_entity.dart';
import 'package:locker_app/domain/entities/user_entity.dart';

class DataBaseEntity {
  List<DepartmentEntity> departments;
  List<LockerEntity> lockers;
  //List<UserEntity> users;
  List<ControllerEntity> controllers;
  List<DoorSizeEntity> doorSizes;
  List<DoorEntity> doors;
  List<MovementEntity> movements;
  List<RequestComandEntity> requestComand;
  List<ResponseComandEntity> responseComand;

  DataBaseEntity({
    required this.departments,
    required this.lockers,
    //required this.users,
    required this.controllers,
    required this.doorSizes,
    required this.doors,
    required this.movements,
    required this.requestComand,
    required this.responseComand,
  });

  factory DataBaseEntity.fromJson(Map<String, dynamic> json) => DataBaseEntity(
    departments: List<DepartmentEntity>.from(
      json["department"].map((x) => DepartmentEntity.fromJson(x)),
    ),
    lockers: List<LockerEntity>.from(
      json["lockers"].map((x) => LockerEntity.fromJson(x)),
    ),
   /*  users: List<UserEntity>.from(
      json["users"].map((x) => UserEntity.fromJson(x)),
    ), */
    controllers: List<ControllerEntity>.from(
      json["controllers"].map((x) => ControllerEntity.fromJson(x)),
    ),
    doorSizes: List<DoorSizeEntity>.from(
      json["door_sizes"].map((x) => DoorSizeEntity.fromJson(x)),
    ),
    doors: List<DoorEntity>.from(
      json["doors"].map((x) => DoorEntity.fromJson(x)),
    ),
    movements: List<MovementEntity>.from(
      json["movements"].map((x) => MovementEntity.fromJson(x)),
    ),
    requestComand: List<RequestComandEntity>.from(
      json["request_comands"].map((x) => RequestComandEntity.fromJson(x)),
    ),
    responseComand: List<ResponseComandEntity>.from(
      json["response_comands"].map((x) => ResponseComandEntity.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
    "lockers": List<dynamic>.from(lockers.map((x) => x.toJson())),
    //"users": List<dynamic>.from(users.map((x) => x.toJson())),
    "controllers": List<dynamic>.from(controllers.map((x) => x.toJson())),
    "door_sizes": List<dynamic>.from(doorSizes.map((x) => x.toJson())),
    "doors": List<dynamic>.from(doors.map((x) => x.toJson())),
    "movements": List<dynamic>.from(movements.map((x) => x.toJson())),
    "reques_comand": List<dynamic>.from(movements.map((x) => x.toJson())),
    "response_comand": List<dynamic>.from(movements.map((x) => x.toJson())),
  };
}
