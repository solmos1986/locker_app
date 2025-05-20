class DoorAvailable {
  int number;
  int doorId;
  String name;
  int total;

  DoorAvailable({
    required this.name,
    required this.doorId,
    required this.number,
    required this.total,
  });

  factory DoorAvailable.fromJson(Map<String, dynamic> json) => DoorAvailable(
    number: json["number"],
    doorId: json["door_id"],
    name: json["name"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "door_id": doorId,
    "name": name,
    "total": total,
  };

  DoorAvailable copy({int? number, int? doorId, String? name, int? total}) =>
      DoorAvailable(
        doorId: doorId ?? this.doorId,
        number: number ?? this.number,
        name: name ?? this.name,
        total: total ?? this.total,
      );
}
