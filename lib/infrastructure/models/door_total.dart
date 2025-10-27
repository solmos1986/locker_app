class DoorTotalModel {
  String name;
  int doorId;
  String nameSize;

  DoorTotalModel({
    required this.name,
    required this.doorId,
    required this.nameSize,
  });

  factory DoorTotalModel.fromJson(Map<String, dynamic> json) => DoorTotalModel(
    name: json["name"],
    doorId: json["door_id"],
    nameSize: json["name_size"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "door_id": doorId,
    "name_size": nameSize,
  };

  DoorTotalModel copy({String? name, int? doorId, String? nameSize}) =>
      DoorTotalModel(
        doorId: doorId ?? this.doorId,
        name: name ?? this.name,
        nameSize: nameSize ?? this.nameSize,
      );
}
