class MovementEntity {
  int movementId;
  int userId;
  int doorId;
  String code;
  int delivered;
  DateTime createAt;

  MovementEntity({
    required this.movementId,
    required this.userId,
    required this.doorId,
    required this.code,
    required this.delivered,
    required this.createAt,
  });

  factory MovementEntity.fromJson(Map<String, dynamic> json) => MovementEntity(
    movementId: json["movement_id"],
    userId: json["user_id"],
    doorId: json["door_id"],
    code: json["code"],
    delivered: json["delivered"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "movement_id": movementId,
    "user_id": userId,
    "door_id": doorId,
    "code": code,
    "delivered": delivered,
    "create_at": createAt.toIso8601String(),
  };

  MovementEntity copy({
    int? movementId,
    int? userId,
    int? doorId,
    String? code,
    int? delivered,
    DateTime? createAt,
  }) => MovementEntity(
    movementId: movementId ?? this.movementId,
    userId: userId ?? this.userId,
    doorId: doorId ?? this.doorId,
    code: code ?? this.code,
    delivered: delivered ?? this.delivered,
    createAt: createAt ?? this.createAt,
  );
}
