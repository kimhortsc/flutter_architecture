import 'package:flutter_app_architecture/domain/result.dart';
import 'package:flutter_app_architecture/domain/model/resource.dart';

abstract class ResourceRepository{
  Future<Result<Resource>> findOne(int id);
}