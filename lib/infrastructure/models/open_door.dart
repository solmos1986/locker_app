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
    name: json["name"],
    doorId: json["door_id"],
    doorSizeId: json["door_size_id"],
  );

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
