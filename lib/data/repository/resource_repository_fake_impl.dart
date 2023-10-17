import 'package:flutter_app_architecture/data/dto/error_dto.dart';
import 'package:flutter_app_architecture/data/dto/resource_dto.dart';
import 'package:flutter_app_architecture/data/mapper/resource_mapper.dart';
import 'package:flutter_app_architecture/domain/result.dart';
import 'package:flutter_app_architecture/domain/model/resource.dart';
import 'package:flutter_app_architecture/domain/repository/resource_repository.dart';

class ResourceRepositoryFakeImpl implements ResourceRepository {

  Map<String, dynamic> json = {
    'data': {
      'id': 1,
      'name': 'cerulean',
      'year': 2000,
      'color': '#98B2D1',
      'pantone_value': '15-4020'
    }
  };


  Map<String, dynamic> jsonError = {
    'code': 404,
    'message': 'not found',
  };


  @override
  Future<Result<Resource>> findOne(int id) async {

    // final error = ErrorDto.fromJson(jsonError);
    //
    // return Result.error(message: error.message);

   await Future.delayed(const Duration(seconds: 1));

    final resourceDto = ResourceDto.fromJson(json['data']);
    final resource = ResourceMapper.toModel(resourceDto);
    return Result.success(data: resource);
  }
}