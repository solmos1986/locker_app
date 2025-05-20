class DoorSizeModel {
  int doorSizeId;
  String name;
  DateTime createAt;

  DoorSizeModel({
    required this.doorSizeId,
    required this.name,
    required this.createAt,
  });

  factory DoorSizeModel.fromJson(Map<String, dynamic> json) => DoorSizeModel(
    doorSizeId: json["door_size_id"],
    name: json["name"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "door_size_id": doorSizeId,
    "name": name,
    "create_at": createAt.toIso8601String(),
  };

  DoorSizeModel copy({int? doorSizeId, String? name, DateTime? createAt}) =>
      DoorSizeModel(
        doorSizeId: doorSizeId ?? this.doorSizeId,
        name: name ?? this.name,
        createAt: createAt ?? this.createAt,
      );
}
