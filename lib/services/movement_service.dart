import 'package:dio/dio.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/infrastructure/models/status_model.dart';

class MovementService {
  final _dio = Dio();

  Future<StatusModel> storeMovement(
    int departamentId,
    int doorId,
    String code,
    String idRef,
  ) async {
    final response = await _dio.post(
      '${EnvConfig.baseUrl}/api/movement/pending',
      options: Options(headers: {'Authorization': 'Bearer ${EnvConfig.token}'}),
      data: {
        "departament_id": departamentId,
        "door_id": doorId,
        "code": code,
        "id_ref": idRef,
        "create_at": DateTime.now(),
      },
    );

    StatusModel status = StatusModel.fromJson(response.data);
    return status;
  }

  Future<StatusModel> updateMovement(
    int departamentId,
    int doorId,
    String code,
    String idRef,
  ) async {
    final response = await _dio.post(
      '${EnvConfig.baseUrl}/api/movement/received',
      options: Options(headers: {'Authorization': 'Bearer ${EnvConfig.token}'}),
      data: {
        "departamentId": departamentId,
        "door_id": doorId,
        "code": code,
        "id_ref": idRef,
        "create_at": DateTime.now().toString(),
      },
    );

    StatusModel status = StatusModel.fromJson(response.data);
    return status;
  }
}
