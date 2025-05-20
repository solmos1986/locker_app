class UserModel {
  int userId;
  int lockerId;
  String name;
  int state;
  DateTime createAt;

  UserModel({
    required this.userId,
    required this.lockerId,
    required this.name,
    required this.state,
    required this.createAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["user_id"],
    lockerId: json["locker_id"],
    name: json["name"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "locker_id": lockerId,
    "name": name,
    "state": state,
    "create_at": createAt.toIso8601String(),
  };

  UserModel copy({int? userId, int? lockerId, String? name, int? state}) =>
      UserModel(
        userId: userId ?? this.userId,
        lockerId: lockerId ?? this.lockerId,
        name: name ?? this.name,
        state: state ?? this.state,
        createAt: createAt,
      );
}
