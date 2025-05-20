import 'package:dio/dio.dart';
import 'package:locker_app/helper/env.dart';
import 'package:locker_app/infrastructure/database_model.dart';

class DatabaseService {
  final _dio = Dio();

  Future<DataBaseModel> getAllDataBase() async {
    final response = await _dio.get('${EnvConfig.baseUrl}/api/database');

    return DataBaseModel.fromJson(response.data);
  }
}
