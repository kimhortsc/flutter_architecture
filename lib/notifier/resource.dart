import 'dart:async';

import 'package:flutter_app_architecture/domain/model/resource.dart';
import 'package:flutter_app_architecture/domain/repository/resource_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResourceFamilyAsyncNotifier extends FamilyAsyncNotifier<Resource?, ResourceRepository> {
  late ResourceRepository _resourceRepository;

  @override
  FutureOr<Resource?> build(ResourceRepository arg) {
    _resourceRepository = arg;
    return null;
  }

  Future<void> findOne(int id) async {

    state = const AsyncLoading();
    final result = await _resourceRepository.findOne(id);
    if (result.data != null) {
      state = AsyncData(result.data);
    } else {
      state =
          AsyncError(result.message!, StackTrace.fromString(result.message!));
    }
  }
}

final resourceAsyncNotifierProviderFamily = AsyncNotifierProviderFamily<ResourceFamilyAsyncNotifier, Resource?, ResourceRepository>(ResourceFamilyAsyncNotifier.new);
