class DoorMessageModel {
  int message;

  DoorMessageModel({required this.message});

  factory DoorMessageModel.fromJson(Map<dynamic, dynamic> json) =>
      DoorMessageModel(message: _toInt(json["message"]));

  static int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? "") ?? 0;
  }

  Map<String, dynamic> toJson() => {"message": message};
}
