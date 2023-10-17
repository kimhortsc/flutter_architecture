import 'package:dio/dio.dart';

class ResourceApi {
  final Dio _dio;

  ResourceApi(this._dio);

  Future<Response<dynamic>> findOne(int id) async => await _dio.get("https://reqres.in/api/resource/1");
}