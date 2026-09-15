class DepartmentEntity {
  int departmentId;
  int buildingId;
  String name;
  int state;
  DateTime createAt;
  DateTime updateAt;

  DepartmentEntity({
    required this.departmentId,
    required this.buildingId,
    required this.name,
    required this.state,
    required this.createAt,
    required this.updateAt,
  });

  factory DepartmentEntity.fromJson(Map<String, dynamic> json) => DepartmentEntity(
    departmentId: json["department_id"],
    buildingId: json["building_id"],
    name: json["name"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
    updateAt: DateTime.parse(json["update_at"]),
  );

  Map<String, dynamic> toJson() => {
    "department_id": departmentId,
    "building_id": buildingId,
    "name": name,
    "state": state,
    "create_at": createAt.toIso8601String(),
    "update_at": updateAt.toIso8601String(),
  };

  DepartmentEntity copy({
    int? departmentId,
    int? buildingId,
    String? name,
    int? state,
    DateTime? createAt,
    DateTime? updateAt,
  }) => DepartmentEntity(
    departmentId: departmentId ?? this.departmentId,
    buildingId: buildingId ?? this.buildingId,
    state: state ?? this.state,
    name: name ?? this.name,
    createAt: this.createAt,
    updateAt: this.updateAt,
  );
}
