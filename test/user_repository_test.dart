import 'package:dio/dio.dart';
import 'package:flutter_app_architecture/data/api/user_api.dart';
import 'package:flutter_app_architecture/data/dto/error_dto.dart';
import 'package:flutter_app_architecture/data/dto/user_dto.dart';
import 'package:flutter_app_architecture/data/mapper/user_mapper.dart';
import 'package:flutter_app_architecture/data/repository/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';


void main() {

  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;


  int page = 1;
  int perPage = 1;
  int total = 1;
  int totalPages = 1;


  Map<String, dynamic> json = {
    'page': page,
    'per_page': perPage,
    'total': total,
    'total_pages': totalPages,
    'data': [
      {
        'id': 1,
        'email': 'email',
        'first_name': 'firstName',
        'last_name': 'lastName',
        'avatar': 'avatar'
      }
    ]
  };


  Map<String, dynamic> jsonError = {
    'code': 404,
    'message': 'not found',
  };

  ErrorDto errorDto = ErrorDto(message: "message", code: 404);

  test('return users if fetch successfully', () async {

    // UserDto(
    //   page: page,
    //   perPage: perPage,
    //   total: total,
    //   totalPages: totalPages,
    //   data: data
    // );

    const route = "https://reqres.in/api/users?page=2";

    dioAdapter.onGet(route, (request) {
      return request.reply(200, json);
    });

    final userApi = UserApi(dio);

    final userRepo = UserRepository(userApi);

    final res = await userRepo.getUsers();

    final userDto = UserDto.fromJson(json);
    final users = UserMapper.toModels(userDto);

    expect(res.data, users);

    


   // expect(res.message, jsonError['message']);
   // expect(res.code, 404);


   // expect(res.message, "data");

    // const path = "https://reqres.in/api/users?page=2";
    //
    // const message = '{"userId": 1, "id": 2, "title": "mock"}';
    //
    // dioAdapter.onGet(path, (request) {
    //   request.reply(200, '{"userId": 1, "id": 2, "title": "mock"}');
    // });

    //final users = await userApi.getUsers();
   // expect(users.data.toString(), message);
    // final userRepository = UserRepository(dio);
    //  final users = await userRepository.getUsers();
    //  expect(users.message, message);
    
  });
}