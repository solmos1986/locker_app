class RequestComandEntity {
  int requestComandId;
  int doorId;
  String name;
  String comand;
  DateTime createAt;

  RequestComandEntity({
    required this.requestComandId,
    required this.doorId,
    required this.name,
    required this.comand,
    required this.createAt,
  });

  factory RequestComandEntity.fromJson(Map<String, dynamic> json) =>
      RequestComandEntity(
        requestComandId: json["request_comand_id"],
        doorId: json["door_id"],
        name: json["name"],
        comand: json["comand"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
    "request_comand_id": requestComandId,
    "door_id": doorId,
    "comand": comand,
    "name": name,
    "create_at": createAt.toIso8601String(),
  };

  RequestComandEntity copy({
    int? requestComandId,
    int? doorId,
    String? name,
    String? comand,
    DateTime? createAt,
  }) => RequestComandEntity(
    requestComandId: requestComandId ?? this.requestComandId,
    doorId: doorId ?? this.doorId,
    name: name ?? this.name,
    comand: comand ?? this.comand,
    createAt: createAt ?? this.createAt,
  );
}
