import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app_architecture/data/dto/error_dto.dart';
import 'package:flutter_app_architecture/domain/result.dart';

import '../../domain/model/user.dart';
import '../api/user_api.dart';
import '../dto/user_dto.dart';
import '../mapper/user_mapper.dart';

class UserRepository {

  late UserApi _userApi;

  UserRepository(UserApi userApi){
    _userApi = userApi;
  }

  Future<Result<List<User>>> getUsers() async {
    try {
      final result = await _userApi.getUsers();
      return Result.success(data: UserMapper.toModels(UserDto.fromJson(result.data)));
     // return Result.success(data: result.data);
    } on DioException catch (exc) {
     // final errorDto = ErrorDto.fromJson(exc.response as Map<String, dynamic>);
      print(exc.message);

      final errorDto = ErrorDto.fromJson(exc.response!.data);

      return Result.errorWithCode(message: errorDto.message, code: 200);

    } on SocketException catch (error) {
      return Result.error(message: "${error.message} ${error.address} ${error.osError} ${error.port}");
    }
  }
}
