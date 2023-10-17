import 'package:dio/dio.dart';
import 'package:flutter_app_architecture/data/api/resource_api.dart';
import 'package:flutter_app_architecture/data/dto/error_dto.dart';
import 'package:flutter_app_architecture/data/dto/resource_dto.dart';
import 'package:flutter_app_architecture/data/mapper/resource_mapper.dart';
import 'package:flutter_app_architecture/domain/result.dart';
import 'package:flutter_app_architecture/domain/model/resource.dart';
import 'package:flutter_app_architecture/domain/repository/resource_repository.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourceApi _resourceApi;

  ResourceRepositoryImpl(this._resourceApi);

  @override
  Future<Result<Resource>> findOne(int id) async {
    try {
      final result = await _resourceApi.findOne(id);
      final resourceDto = ResourceDto.fromJson(result.data['data']);
      final resource = ResourceMapper.toModel(resourceDto);
      return Result.success(data: resource);
    } on DioException catch (exc) {
      final result = exc.response?.data;
      final errorDto = ErrorDto.fromJson(result);
      return Result.errorWithCode(message: errorDto.message, code: errorDto.code);

      //final result = exc.response?.data;
      final error = ErrorDto.fromJson(result);

      final message = error.message ?? "Unknown Error";
      final code = error.code;

      return (code == null) ? Result.error(message: message) : Result.errorWithCode(message: message, code: code);
    }
  }
}
