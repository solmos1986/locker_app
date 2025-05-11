class LockerModel {
    int id;
    int clientId;
    String macAdd;
    int state;

    LockerModel({
        required this.id,
        required this.clientId,
        required this.macAdd,
        required this.state,
    });

    factory LockerModel.fromJsonMap(Map<String, dynamic> json) => LockerModel(
        id: json["id"],
        clientId: json["clientId"],
        macAdd: json["macAdd"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "macAdd": macAdd,
        "state": state,
    };

     LockerModel copy({int? id, int? clientId, String? macAdd, int? state}) =>
      LockerModel(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        macAdd: macAdd ?? this.macAdd,
        state: state ?? this.state,
      );
}