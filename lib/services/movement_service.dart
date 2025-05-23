import 'package:dio/dio.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/infrastructure/models/status_model.dart';
import 'package:locker_app/domain/entities/user_entity.dart';

class MovementService {
  final _dio = Dio();

  Future<StatusModel> storeMovement(int userId, int doorId, String code) async {
    final response = await _dio.post(
      '${EnvConfig.baseUrl}/api/movement',
      data: {"user_id": userId, "door_id": doorId, "code": code},
    );

    StatusModel status = StatusModel.fromJson(response.data);
    return status;
  }

  /* Future<List<UserModel>> updateMovement(int movementId) async {
    final response = await _dio.post(
      '${EnvConfig.baseUrl}/api/movement',
      data: {"movement_id": movementId},
    );

    List<UserModel> users =
        (response.data as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
    return users;
  } */
}
