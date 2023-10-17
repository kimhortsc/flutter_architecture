import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/data/api/resource_api.dart';
import 'package:flutter_app_architecture/data/repository/resource_repository_fake_impl.dart';
import 'package:flutter_app_architecture/data/repository/resource_repository_impl.dart';
import 'package:flutter_app_architecture/notifier/resource.dart';
import 'package:flutter_app_architecture/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  testWidgets('Resource Screen retrieved data successfully',
      (widgetTester) async {
    final dio = Dio();
    final dioAdapter = DioAdapter(dio: dio);
    dio.httpClientAdapter = dioAdapter;

    Map<String, dynamic> json = {
      'data': {
        'id': 1,
        'name': 'name',
        'year': '2000',
        'color': 'color',
        'pantone_value': 'avatar'
      }
    };

    Map<String, dynamic> jsonError = {
      'code': 404,
      'message': 'not found',
    };

    const route = "https://reqres.in/api/resource/1";
    dioAdapter.onGet(route, (request) {
      return request.reply(200, json);
    });

    final resourceApi = ResourceApi(dio);

    // await widgetTester.pumpWidget(ProviderScope(
    //   overrides: [
    //     resourceAsyncNotifierProviderFamily.overrideWithProvider((argument) {
    //       return resourceAsyncNotifierProviderFamily(
    //           ResourceRepositoryImpl(ResourceApi(Dio())));
    //     })
    //   ],
    //   child: const ResourceScreen(),
    // ));


    await widgetTester.pumpWidget(const ResourceScreen());

    final textButton = find.byType(TextButton);
    await widgetTester.tap(textButton);

    await widgetTester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await widgetTester.pumpAndSettle();
    // await widgetTester.pumpAndSettle(const Duration(seconds: 5));

    //expect(find.text('Unknown Error'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('name'), findsOneWidget);
    expect(find.text('year'), findsOneWidget);
    expect(find.text('color'), findsOneWidget);
    expect(find.text('avatar'), findsOneWidget);

    // 'name': 'name',
    //     'year': '2000',
    //     'color': 'color',
    //     'pantone_value': 'avatar'
  });
}
