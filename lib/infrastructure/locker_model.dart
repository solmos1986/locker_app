class LockerModel {
  int lockerId;
  int clientId;
  String macAdd;
  int state;
  DateTime createAt;

  LockerModel({
    required this.lockerId,
    required this.clientId,
    required this.macAdd,
    required this.state,
    required this.createAt,
  });

  factory LockerModel.fromJson(Map<String, dynamic> json) => LockerModel(
    lockerId: json["locker_id"],
    clientId: json["client_id"],
    macAdd: json["macAdd"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "locker_id": lockerId,
    "client_id": clientId,
    "macAdd": macAdd,
    "state": state,
    "create_at": createAt.toIso8601String(),
  };

  LockerModel copy({
    int? lockerId,
    int? clientId,
    String? macAdd,
    int? state,
  }) => LockerModel(
    lockerId: lockerId ?? this.lockerId,
    clientId: clientId ?? this.clientId,
    macAdd: macAdd ?? this.macAdd,
    state: state ?? this.state,
    createAt: createAt,
  );
}
