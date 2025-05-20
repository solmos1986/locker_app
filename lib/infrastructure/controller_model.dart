class ControllerModel {
  int controllerId;
  int lockerId;
  String address485;
  DateTime createAt;

  ControllerModel({
    required this.controllerId,
    required this.lockerId,
    required this.address485,
    required this.createAt,
  });

  factory ControllerModel.fromJson(Map<String, dynamic> json) =>
      ControllerModel(
        controllerId: json["controller_id"],
        lockerId: json["locker_id"],
        address485: json["address485"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
    "controller_id": controllerId,
    "locker_id": lockerId,
    "address485": address485,
    "create_at": createAt.toIso8601String(),
  };

  ControllerModel copy({
    int? controllerId,
    int? lockerId,
    String? address485,
    DateTime? createAt,
  }) => ControllerModel(
    lockerId: lockerId ?? this.lockerId,
    createAt: createAt ?? this.createAt,
    controllerId: lockerId ?? this.lockerId,
    address485: address485 ?? this.address485,
  );
}
