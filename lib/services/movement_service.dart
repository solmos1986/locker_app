import 'package:dio/dio.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/infrastructure/status_model.dart';
import 'package:locker_app/infrastructure/user_model.dart';

class MovementService {
  final _dio = Dio();

  Future<StatusModel> storeMovement(int doorId, String code) async {
    final response = await _dio.post(
      '${EnvConfig.baseUrl}/api/movement',
      data: {"door_id": doorId, "code": code},
    );

    StatusModel status = StatusModel.fromJson(response.data);
    return status;
  }

  Future<List<UserModel>> updateMovement(int movementId) async {
    final response = await _dio.post(
      '${EnvConfig.baseUrl}/api/movement',
      data: {"movement_id": movementId},
    );

    List<UserModel> users =
        (response.data as List)
            .map((data) => UserModel.fromJson(data))
            .toList();
    return users;
  }
}
