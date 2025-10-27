class ControllerEntity {
  int controllerId;
  int lockerId;
  String serie;
  String name;
  DateTime createAt;

  ControllerEntity({
    required this.controllerId,
    required this.lockerId,
    required this.name,
    required this.serie,
    required this.createAt,
  });

  factory ControllerEntity.fromJson(Map<String, dynamic> json) =>
      ControllerEntity(
        controllerId: json["controller_id"],
        lockerId: json["locker_id"],
        name: json["name"],
        serie: json["serie"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
    "controller_id": controllerId,
    "locker_id": lockerId,
    "name": name,
    "serie": serie,
    "create_at": createAt.toIso8601String(),
  };

  ControllerEntity copy({
    int? controllerId,
    int? lockerId,
    String? serie,
    String? name,
    DateTime? createAt,
  }) => ControllerEntity(
    lockerId: lockerId ?? this.lockerId,
    name: name ?? this.name,
    createAt: createAt ?? this.createAt,
    controllerId: lockerId ?? this.lockerId,
    serie: serie ?? this.serie,
  );
}
