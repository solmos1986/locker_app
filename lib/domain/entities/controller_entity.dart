class ControllerEntity {
  int controllerId;
  int lockerId;
  String address485;
  String name;
  DateTime createAt;

  ControllerEntity({
    required this.controllerId,
    required this.lockerId,
    required this.name,
    required this.address485,
    required this.createAt,
  });

  factory ControllerEntity.fromJson(Map<String, dynamic> json) =>
      ControllerEntity(
        controllerId: json["controller_id"],
        lockerId: json["locker_id"],
        name: json["name"],
        address485: json["address485"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
    "controller_id": controllerId,
    "locker_id": lockerId,
    "name": name,
    "address485": address485,
    "create_at": createAt.toIso8601String(),
  };

  ControllerEntity copy({
    int? controllerId,
    int? lockerId,
    String? address485,
    String? name,
    DateTime? createAt,
  }) => ControllerEntity(
    lockerId: lockerId ?? this.lockerId,
    name: name ?? this.name,
    createAt: createAt ?? this.createAt,
    controllerId: lockerId ?? this.lockerId,
    address485: address485 ?? this.address485,
  );
}
