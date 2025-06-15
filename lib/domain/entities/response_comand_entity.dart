class ResponseComandEntity {
  int responseComandId;
  int requestComandId;
  String name;
  String comand;
  DateTime createAt;

  ResponseComandEntity({
    required this.responseComandId,
    required this.requestComandId,
    required this.name,
    required this.comand,
    required this.createAt,
  });

  factory ResponseComandEntity.fromJson(Map<String, dynamic> json) =>
      ResponseComandEntity(
        responseComandId: json["response_comand_id"],
        requestComandId: json["request_comand_id"],
        name: json["name"],
        comand: json["comand"],
        createAt: DateTime.parse(json["create_at"]),
      );

  Map<String, dynamic> toJson() => {
    "response_comand_id": responseComandId,
    "request_comand_id": requestComandId,
    "comand": comand,
    "name": name,
    "create_at": createAt.toIso8601String(),
  };

  ResponseComandEntity copy({
    int? responseComandId,
    int? requestComandId,
    String? name,
    String? comand,
    DateTime? createAt,
  }) => ResponseComandEntity(
    responseComandId: responseComandId ?? this.responseComandId,
    requestComandId: requestComandId ?? this.requestComandId,
    name: name ?? this.name,
    comand: comand ?? this.comand,
    createAt: createAt ?? this.createAt,
  );
}
