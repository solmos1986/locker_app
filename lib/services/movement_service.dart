import 'package:dio/dio.dart';
import 'package:locker_app/infrastructure/user_model.dart';

class UserService {
  final _dio = Dio();

  Future<List<UserModel>> getAllDataBase() async {
    final response = await _dio.get(
      'http://192.168.1.135:80/lock-app/public/api/movimiento',
    );

    List<UserModel> users =
        (response.data as List)
            .map((data) => UserModel.fromJsonMap(data))
            .toList();
    return users;
  }
}
