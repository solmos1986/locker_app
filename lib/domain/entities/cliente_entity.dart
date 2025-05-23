class ClientEntity {
  int clientId;
  String name;
  DateTime createAt;

  ClientEntity({
    required this.clientId,
    required this.name,
    required this.createAt,
  });

  factory ClientEntity.fromJson(Map<String, dynamic> json) => ClientEntity(
    clientId: json["client_id"],
    name: json["name"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "client_id": clientId,
    "name": name,
    "create_at": createAt.toIso8601String(),
  };
  
  ClientEntity copy({int? clientId, String? name}) => ClientEntity(
    clientId: clientId ?? this.clientId,
    name: name ?? this.name,
    createAt: createAt,
  );
}
