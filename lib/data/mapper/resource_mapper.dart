import 'package:flutter_app_architecture/data/dto/resource_dto.dart';
import 'package:flutter_app_architecture/domain/model/resource.dart';

class ResourceMapper {
  static Resource toModel(ResourceDto dto) =>
      Resource(dto.id!, dto.name!, dto.year!, dto.color!, dto.pantoneValue!);

  static ResourceDto toDto(Resource resource) => ResourceDto(
      id: resource.id,
      name: resource.name,
      year: resource.year,
      color: resource.color,
      pantoneValue: resource.pantoneValue);
}
