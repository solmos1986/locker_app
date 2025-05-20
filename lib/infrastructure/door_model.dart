class DoorModel {
  int doorId;
  int doorSizeId;
  int controllerId;
  int number;
  String channel;
  int state;
  DateTime createAt;

  DoorModel({
    required this.doorId,
    required this.doorSizeId,
    required this.controllerId,
    required this.number,
    required this.channel,
    required this.state,
    required this.createAt,
  });

  factory DoorModel.fromJson(Map<String, dynamic> json) => DoorModel(
    doorId: json["door_id"],
    doorSizeId: json["door_size_id"],
    controllerId: json["controller_id"],
    number: json["number"],
    channel: json["channel"],
    state: json["state"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "door_id": doorId,
    "door_size_id": doorSizeId,
    "controller_id": controllerId,
    "number": number,
    "channel": channel,
    "state": state,
    "create_at": createAt.toIso8601String(),
  };

  DoorModel copy({
    int? doorId,
    int? doorSizeId,
    int? controllerId,
    int? number,
    String? channel,
    int? state,
    DateTime? createAt,
  }) => DoorModel(
    doorSizeId: doorSizeId ?? this.doorSizeId,
    doorId: doorId ?? this.doorId,
    controllerId: doorId ?? this.doorId,
    number: number ?? this.number,
    channel: channel ?? this.channel,
    state: state ?? this.state,
    createAt: createAt ?? this.createAt,
  );
}
