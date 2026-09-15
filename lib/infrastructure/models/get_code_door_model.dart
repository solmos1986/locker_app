class GetCodeDoorModel {
  String requestComand;
  String nameRequest;
  String responseComand;
  String nameResponse;

  GetCodeDoorModel({
    required this.requestComand,
    required this.nameRequest,
    required this.responseComand,
    required this.nameResponse,
  });
  factory GetCodeDoorModel.fromJson(Map<String, dynamic> json) => GetCodeDoorModel(
    requestComand: json["request_comand"],
    nameRequest: json["name_request"],
     responseComand: json["response_comand"],
    nameResponse: json["name_response"],
  );

  Map<String, dynamic> toJson() => {
    "request_comand": requestComand,
    "name_request": nameRequest,
    "response_comand": responseComand,
    "name_response": nameResponse,
  };
}
