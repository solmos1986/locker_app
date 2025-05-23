import 'package:locker_app/domain/entities/cliente_entity.dart';
import 'package:locker_app/domain/entities/controller_entity.dart';
import 'package:locker_app/domain/entities/door_entity.dart';
import 'package:locker_app/domain/entities/door_size_entity.dart';
import 'package:locker_app/domain/entities/locker_entity.dart';
import 'package:locker_app/domain/entities/movement_entity.dart';
import 'package:locker_app/domain/entities/user_entity.dart';

class DataBaseEntity {
    List<ClientEntity> clients;
    List<LockerEntity> lockers;
    List<UserEntity> users;
    List<ControllerEntity> controllers;
    List<DoorSizeEntity> doorSizes;
    List<DoorEntity> doors;
    List<MovementEntity> movements;

    DataBaseEntity({
        required this.clients,
        required this.lockers,
        required this.users,
        required this.controllers,
        required this.doorSizes,
        required this.doors,
        required this.movements,
    });

    factory DataBaseEntity.fromJson(Map<String, dynamic> json) => DataBaseEntity(
        clients: List<ClientEntity>.from(json["clients"].map((x) => ClientEntity.fromJson(x))),
        lockers: List<LockerEntity>.from(json["lockers"].map((x) => LockerEntity.fromJson(x))),
        users: List<UserEntity>.from(json["users"].map((x) => UserEntity.fromJson(x))),
        controllers: List<ControllerEntity>.from(json["controllers"].map((x) => ControllerEntity.fromJson(x))),
        doorSizes: List<DoorSizeEntity>.from(json["door_sizes"].map((x) => DoorSizeEntity.fromJson(x))),
        doors: List<DoorEntity>.from(json["doors"].map((x) => DoorEntity.fromJson(x))),
        movements: List<MovementEntity>.from(json["movements"].map((x) => MovementEntity.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "clients": List<dynamic>.from(clients.map((x) => x.toJson())),
        "lockers": List<dynamic>.from(lockers.map((x) => x.toJson())),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "controllers": List<dynamic>.from(controllers.map((x) => x.toJson())),
        "door_sizes": List<dynamic>.from(doorSizes.map((x) => x.toJson())),
        "doors": List<dynamic>.from(doors.map((x) => x.toJson())),
        "movements": List<dynamic>.from(movements.map((x) => x.toJson())),
    };
}
