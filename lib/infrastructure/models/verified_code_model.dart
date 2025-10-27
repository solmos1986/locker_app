class VerifiedCodeModel {
  int doorId;
  int departmentId;
  int movementId;
  String code;
  int numberDoor;
  String name;
  String nameSizeDoor;
  String idRef;
  DateTime createAt;

  VerifiedCodeModel({
    required this.doorId,
    required this.departmentId,
    required this.movementId,
    required this.code,
    required this.numberDoor,
    required this.name,
    required this.nameSizeDoor,
    required this.idRef,
    required this.createAt,
  });

  factory VerifiedCodeModel.fromJson(Map<String, dynamic> json) =>
      VerifiedCodeModel(
        doorId: json["door_id"],
        departmentId: json["department_id"],
        movementId: json["movement_id"],
        code: json["code"],
        numberDoor: json["number"],
        name: json["name"],
        nameSizeDoor: json["name_size"],
        idRef: json["id_ref"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {"movement_id": movementId, "code": code};
}
