import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/notifier/resource.dart';
import 'package:flutter_app_architecture/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_architecture/data/repository/resource_repository_fake_impl.dart';

void main() {

  testWidgets('Resource Screen retrieved data successfully',
      (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(
      // overrides: [
      //
      //   resourceAsyncNotifierProviderFamily.overrideWithProvider((argument) =>
      //       resourceAsyncNotifierProviderFamily(ResourceRepositoryFakeImpl()))
      // ],
      child: ResourceScreen(),
    ));

    final textButton = find.byType(TextButton);
     await widgetTester.tap(textButton);

    await widgetTester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();
    // await widgetTester.pumpAndSettle(const Duration(seconds: 5));

   //expect(find.text('Unknown Error'), findsOneWidget);
   expect(find.text('1'), findsOneWidget);
    expect(find.text('cerulean'), findsOneWidget);
   expect(find.text('2000'), findsOneWidget);
    expect(find.text('#98B2D1'), findsOneWidget);
    expect(find.text('15-4020'), findsOneWidget);



  });
}
