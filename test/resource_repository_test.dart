import 'package:dio/dio.dart';
import 'package:flutter_app_architecture/data/api/resource_api.dart';
import 'package:flutter_app_architecture/data/dto/error_dto.dart';
import 'package:flutter_app_architecture/data/repository/resource_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {

  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;

  Map<String, dynamic> json = {
    'data': {
        'id': 1,
        'name': 'email',
        'year': 'firstName',
        'color': 'lastName',
        'pantone_value': 'avatar'
      }
  };


  Map<String, dynamic> jsonError = {
    'code': 404,
    'message': 'not found',
  };

  test('return message and error code if fetching failed', () async {

    const route = "https://reqres.in/api/resource/1";

    dioAdapter.onGet(route, (request) {
      return request.reply(404, jsonError);
    });

    final resourceApi = ResourceApi(dio);

    final resourceRepo = ResourceRepositoryImpl(resourceApi);
    final res = await resourceRepo.findOne(1);

    final errorDto = ErrorDto.fromJson(jsonError);

    expect(res.code, errorDto.code);
    expect(res.message, errorDto.message);
  });
}