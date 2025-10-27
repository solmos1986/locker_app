import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/domain/entities/database_entity.dart';

class DatabaseService {
  final _dio = Dio();
  Future<DataBaseEntity> getAllDataBase() async {
    final response = await _dio.get(
      '${EnvConfig.baseUrl}/api/database',
      options: Options(headers: {'Authorization': 'Bearer ${EnvConfig.token}'}),
    );
    log("response ${response.statusCode.toString()}");
    return DataBaseEntity.fromJson(response.data);
  }
}
