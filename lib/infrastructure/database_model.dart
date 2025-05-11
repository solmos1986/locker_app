import 'package:locker_app/infrastructure/locker_model.dart';
import 'package:locker_app/infrastructure/user_model.dart';

class DataBaseModel {
    List<UserModel> users;
    List<LockerModel> lockers;

    DataBaseModel({
        required this.users,
        required this.lockers,
    });

    factory DataBaseModel.fromJson(Map<String, dynamic> json) => DataBaseModel(
        users: List<UserModel>.from(json["users"].map((x) => UserModel.fromJsonMap(x))),
        lockers: List<LockerModel>.from(json["lockers"].map((x) => LockerModel.fromJsonMap(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "lockers": List<dynamic>.from(lockers.map((x) => x.toJson())),
    };
}