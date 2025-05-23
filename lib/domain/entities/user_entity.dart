class UserEntity {
  int userId;
  int clientId;
  String name;
  int state;
  DateTime createAt;

  UserEntity({
    required this.userId,
    required this.clientId,
    required this.name,
    required this.state,
    required this.createAt,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    userId: json["user_id"],
    clientId: json["client_id"],
    name: json["name"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "client_id": clientId,
    "name": name,
    "state": state,
    "create_at": createAt.toIso8601String(),
  };

  UserEntity copy({int? userId, int? clientId, String? name, int? state}) =>
      UserEntity(
        userId: userId ?? this.userId,
        clientId: clientId ?? this.clientId,
        name: name ?? this.name,
        state: state ?? this.state,
        createAt: createAt,
      );
}
