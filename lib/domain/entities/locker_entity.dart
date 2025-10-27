class LockerEntity {
  int lockerId;
  int buildingId;
  String name;
  String address;
  int typeLockerId;
  int state;
  DateTime createAt;

  LockerEntity({
    required this.lockerId,
    required this.buildingId,
    required this.name,
    required this.address,
    required this.typeLockerId,
    required this.state,
    required this.createAt,
  });

  factory LockerEntity.fromJson(Map<String, dynamic> json) => LockerEntity(
    lockerId: json["locker_id"],
    buildingId: json["building_id"],
    name: json["name"],
    address: json["address"],
    typeLockerId: json["type_locker_id"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "locker_id": lockerId,
    "building_id": buildingId,
    "name": name,
    "address": address,
    "type_locker_id": typeLockerId,
    "state": state,
    "create_at": createAt.toIso8601String(),
  };

  LockerEntity copy({
    int? lockerId,
    int? buildingId,
    String? name,
    String? address,
    int? typeLockerId,
    int? state,
  }) => LockerEntity(
    lockerId: lockerId ?? this.lockerId,
    buildingId: buildingId ?? this.buildingId,
    name: name ?? this.name,
    address: address ?? this.address,
    typeLockerId: typeLockerId ?? this.typeLockerId,
    state: state ?? this.state,
    createAt: createAt,
  );
}
