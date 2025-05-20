class MovementModel {
  int movementId;
  int doorId;
  String code;
  int delivered;
  DateTime createAt;

  MovementModel({
    required this.movementId,
    required this.doorId,
    required this.code,
    required this.delivered,
    required this.createAt,
  });

  factory MovementModel.fromJson(Map<String, dynamic> json) => MovementModel(
    movementId: json["movement_id"],
    doorId: json["door_id"],
    code: json["code"],
    delivered: json["delivered"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "movement_id": movementId,
    "door_id": doorId,
    "code": code,
    "delivered": delivered,
    "create_at": createAt.toIso8601String(),
  };

  MovementModel copy({
    int? movementId,
    int? doorId,
    String? code,
    int? delivered,
    DateTime? createAt,
  }) => MovementModel(
    movementId: movementId ?? this.movementId,
    doorId: doorId ?? this.doorId,
    code: code ?? this.code,
    delivered: delivered ?? this.delivered,
    createAt: createAt ?? this.createAt,
  );
}
