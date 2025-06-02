class VerifiedCodeModel {
  int movementId;
  String code;
  int numberDoor;
  String nameSizeDoor;
  DateTime createAt;

  VerifiedCodeModel({
    required this.movementId,
    required this.code,
    required this.numberDoor,
    required this.nameSizeDoor,
    required this.createAt,
  });

  factory VerifiedCodeModel.fromJson(Map<String, dynamic> json) =>
      VerifiedCodeModel(
        movementId: json["movement_id"],
        code: json["code"],
        numberDoor: json["number"],
        nameSizeDoor: json["name"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {"movement_id": movementId, "code": code};
}
