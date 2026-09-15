class OpenDoorModel {
  String name;
  int doorId;
  int doorSizeId;

  OpenDoorModel({
    required this.name,
    required this.doorId,
    required this.doorSizeId,
  });

  factory OpenDoorModel.fromJson(Map<dynamic, dynamic> json) => OpenDoorModel(
    name: (json["name"] ?? "").toString(),
    doorId: _toInt(json["door_id"]),
    doorSizeId: _toInt(json["door_size_id"]),
  );

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? "") ?? 0;
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "door_id": doorId,
    "door_size_id": doorSizeId,
  };

  OpenDoorModel copy({String? name, int? doorId, int? doorSizeId}) =>
      OpenDoorModel(
        doorId: doorId ?? this.doorId,
        name: name ?? this.name,
        doorSizeId: doorSizeId ?? this.doorSizeId,
      );
}
