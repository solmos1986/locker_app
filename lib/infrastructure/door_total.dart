class DoorTotalModel {
  int number;
  int doorId;
  String name;

  DoorTotalModel({
    required this.name,
    required this.doorId,
    required this.number,
  });

  factory DoorTotalModel.fromJson(Map<String, dynamic> json) => DoorTotalModel(
    number: json["number"],
    doorId: json["door_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "door_id": doorId,
    "name": name,
  };

  DoorTotalModel copy({int? number, int? doorId, String? name}) =>
      DoorTotalModel(
        doorId: doorId ?? this.doorId,
        number: number ?? this.number,
        name: name ?? this.name,
      );
}
