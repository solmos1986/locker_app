import 'package:locker_app/infrastructure/cliente_model.dart';
import 'package:locker_app/infrastructure/controller_model.dart';
import 'package:locker_app/infrastructure/door_model.dart';
import 'package:locker_app/infrastructure/door_size_model.dart';
import 'package:locker_app/infrastructure/locker_model.dart';
import 'package:locker_app/infrastructure/movement_model.dart';
import 'package:locker_app/infrastructure/user_model.dart';

class DataBaseModel {
    List<ClientModel> clients;
    List<LockerModel> lockers;
    List<UserModel> users;
    List<ControllerModel> controllers;
    List<DoorSizeModel> doorSizes;
    List<DoorModel> doors;
    List<MovementModel> movements;

    DataBaseModel({
        required this.clients,
        required this.lockers,
        required this.users,
        required this.controllers,
        required this.doorSizes,
        required this.doors,
        required this.movements,
    });

    factory DataBaseModel.fromJson(Map<String, dynamic> json) => DataBaseModel(
        clients: List<ClientModel>.from(json["clients"].map((x) => ClientModel.fromJson(x))),
        lockers: List<LockerModel>.from(json["lockers"].map((x) => LockerModel.fromJson(x))),
        users: List<UserModel>.from(json["users"].map((x) => UserModel.fromJson(x))),
        controllers: List<ControllerModel>.from(json["controllers"].map((x) => ControllerModel.fromJson(x))),
        doorSizes: List<DoorSizeModel>.from(json["door_sizes"].map((x) => DoorSizeModel.fromJson(x))),
        doors: List<DoorModel>.from(json["doors"].map((x) => DoorModel.fromJson(x))),
        movements: List<MovementModel>.from(json["movements"].map((x) => MovementModel.fromJson(x))),
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
