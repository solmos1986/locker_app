class UserModel {
  int id;
  int lockerId;
  String name;
  int state;

  UserModel({
    required this.id,
    required this.lockerId,
    required this.name,
    required this.state,
  });

  factory UserModel.fromJsonMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    lockerId: json["lockerId"],
    name: json["name"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "lockerId": lockerId,
    "name": name,
    "state": state,
  };

  UserModel copy({int? id, int? lockerId, String? name, int? state}) =>
      UserModel(
        id: id ?? this.id,
        lockerId: lockerId ?? this.lockerId,
        name: name ?? this.name,
        state: state ?? this.state,
      );
}
