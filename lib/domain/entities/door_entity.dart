class DoorEntity {
  int doorId;
  int doorSizeId;
  int controllerId;
  int order;
  String name;
  int state;
  DateTime createAt;

  DoorEntity({
    required this.doorId,
    required this.doorSizeId,
    required this.controllerId,
    required this.order,
    required this.name,
    required this.state,
    required this.createAt,
  });

  factory DoorEntity.fromJson(Map<String, dynamic> json) => DoorEntity(
    doorId: json["door_id"],
    doorSizeId: json["door_size_id"],
    controllerId: json["controller_id"],
    order: json["order"],
    name: json["name"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "door_id": doorId,
    "door_size_id": doorSizeId,
    "controller_id": controllerId,
    "order": order,
    "name": name,
    "state": state,
    "create_at": createAt.toIso8601String(),
  };

  DoorEntity copy({
    int? doorId,
    int? doorSizeId,
    int? controllerId,
    int? order,
    String? name,
    int? state,
    DateTime? createAt,
  }) => DoorEntity(
    doorSizeId: doorSizeId ?? this.doorSizeId,
    doorId: doorId ?? this.doorId,
    controllerId: doorId ?? this.doorId,
    order: order ?? this.order,
    name: name ?? this.name,
    state: state ?? this.state,
    createAt: createAt ?? this.createAt,
  );
}
