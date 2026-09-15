class MovementEntity {
  int movementId;
  int departmentId;
  int doorId;
  int buildingId;
  String code;
  int typeMovementId;
  String idRef;
  int statusNotificate;
  int statusIntegrate;
  DateTime createAt;

  MovementEntity({
    required this.movementId,
    required this.departmentId,
    required this.doorId,
    required this.buildingId,
    required this.code,
    required this.typeMovementId,
    required this.idRef,
    required this.statusIntegrate,
    required this.statusNotificate,
    required this.createAt,
  });

  factory MovementEntity.fromJson(Map<String, dynamic> json) => MovementEntity(
    movementId: json["movement_id"],
    departmentId: json["department_id"],
    doorId: json["door_id"],
    buildingId: json["building_id"],
    code: json["code"],
    typeMovementId: json["type_movement_id"],
    idRef: json["id_ref"],
    statusIntegrate: json["status_integrate"],
    statusNotificate: json["status_notificate"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "movement_id": movementId,
    "department_id": departmentId,
    "door_id": doorId,
    "building_id": buildingId,
    "code": code,
    "type_movement_id": typeMovementId,
    "id_ref": idRef,
    "status_integrate": statusIntegrate,
    "status_notificate": statusNotificate,
    "create_at": createAt.toIso8601String(),
  };

  MovementEntity copy({
    int? movementId,
    int? departmentId,
    int? doorId,
    int? buildingId,
    String? code,
    int? typeMovementId,
    String? idRef,
    int? statusIntegrate,
    int? statusNotificate,
    DateTime? createAt,
  }) => MovementEntity(
    movementId: movementId ?? this.movementId,
    departmentId: departmentId ?? this.departmentId,
    doorId: doorId ?? this.doorId,
    buildingId: buildingId ?? this.buildingId,
    code: code ?? this.code,
    typeMovementId: typeMovementId ?? this.typeMovementId,
    idRef: idRef ?? this.idRef,
    statusIntegrate: statusIntegrate ?? this.statusIntegrate,
    statusNotificate: statusNotificate ?? this.statusNotificate,
    createAt: createAt ?? this.createAt,
  );
}
