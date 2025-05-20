class ClientModel {
  int clientId;
  String name;
  DateTime createAt;

  ClientModel({
    required this.clientId,
    required this.name,
    required this.createAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    clientId: json["client_id"],
    name: json["name"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "name": name,
    "create_at": createAt.toIso8601String(),
  };
  
  ClientModel copy({int? clientId, String? name}) => ClientModel(
    clientId: clientId ?? this.clientId,
    name: name ?? this.name,
    createAt: createAt,
  );
}
