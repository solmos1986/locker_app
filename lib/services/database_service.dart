import 'package:dio/dio.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/domain/entities/database_entity.dart';

class DatabaseService {
  final _dio = Dio();

  Future<DataBaseEntity> getAllDataBase() async {
    final response = await _dio.get('${EnvConfig.baseUrl}/api/database');

    return DataBaseEntity.fromJson(response.data);
  }
}
