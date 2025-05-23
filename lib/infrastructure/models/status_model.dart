class StatusModel {
    String status;

    StatusModel({
        required this.status,
    });

    factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
    };
}