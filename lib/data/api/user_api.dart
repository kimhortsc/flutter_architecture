import 'package:dio/dio.dart';

class UserApi {
  final Dio _dio;

  UserApi(this._dio);

  Future<Response<dynamic>> getUsers() async => await _dio.get("https://reqres.in/api/users?page=2");
}
