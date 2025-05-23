class DoorSizeEntity {
  int doorSizeId;
  String name;
  DateTime createAt;

  DoorSizeEntity({
    required this.doorSizeId,
    required this.name,
    required this.createAt,
  });

  factory DoorSizeEntity.fromJson(Map<String, dynamic> json) => DoorSizeEntity(
    doorSizeId: json["door_size_id"],
    name: json["name"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "door_size_id": doorSizeId,
    "name": name,
    "create_at": createAt.toIso8601String(),
  };

  DoorSizeEntity copy({int? doorSizeId, String? name, DateTime? createAt}) =>
      DoorSizeEntity(
        doorSizeId: doorSizeId ?? this.doorSizeId,
        name: name ?? this.name,
        createAt: createAt ?? this.createAt,
      );
}
