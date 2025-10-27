class DoorAvailable {
  String nameSize;
  int doorId;
  String name;
  int total;

  DoorAvailable({
    required this.name,
    required this.doorId,
    required this.nameSize,
    required this.total,
  });

  factory DoorAvailable.fromJson(Map<String, dynamic> json) => DoorAvailable(
    nameSize: json["name_size"],
    doorId: json["door_id"],
    name: json["name"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "name_size": nameSize,
    "door_id": doorId,
    "name": name,
    "total": total,
  };

  DoorAvailable copy({String? nameSize, int? doorId, String? name, int? total}) =>
      DoorAvailable(
        doorId: doorId ?? this.doorId,
        nameSize: nameSize ?? this.nameSize,
        name: name ?? this.name,
        total: total ?? this.total,
      );
}
