import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_architecture/data/api/user_api.dart';
import 'package:flutter_app_architecture/domain/result.dart';
import 'package:flutter_app_architecture/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/model/user.dart';

class AsyncUserNotifier extends AsyncNotifier<Result<List<User>>>{

  final _userRepository = UserRepository(UserApi(Dio()));

  @override
  FutureOr<Result<List<User>>> build() {

    final users = _userRepository.getUsers();

    users.then((value) => null);

     _userRepository.getUsers();


    AsyncData(users);

    return _userRepository.getUsers();
  }

}

final asyncUserProvider = AsyncNotifierProvider<AsyncUserNotifier, Result<List<User>>>(() {

  return AsyncUserNotifier();
});

