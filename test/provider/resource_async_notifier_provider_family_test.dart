import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/data/repository/resource_repository_fake_impl.dart';
import 'package:flutter_app_architecture/domain/model/resource.dart';
import 'package:flutter_app_architecture/domain/repository/resource_repository.dart';
import 'package:flutter_app_architecture/notifier/resource.dart';
import 'package:flutter_app_architecture/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Resource Screen retrieved data successfully', (widgetTester) async {

    WidgetsFlutterBinding.ensureInitialized();

    final customProvider = AsyncNotifierProviderFamily<
        ResourceFamilyAsyncNotifier,
        Resource?,
        ResourceRepository>(() => ResourceFamilyAsyncNotifier());

    await widgetTester.pumpWidget(ProviderScope(
      overrides: [
        resourceAsyncNotifierProviderFamily.overrideWithProvider((argument) {
          argument = ResourceRepositoryFakeImpl();
          return customProvider(ResourceRepositoryFakeImpl());
        }),
        resourceAsyncNotifierProviderFamily.overriddenFamily
      ],
      child: const ResourceScreen(),
    ));

    final textButton = find.byType(TextButton);
    await widgetTester.tap(textButton);

    await widgetTester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await widgetTester.pumpAndSettle();
    // await widgetTester.pumpAndSettle(const Duration(seconds: 5));

    //expect(find.text('Unknown Error'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    // expect(find.text('email'), findsOneWidget);
    //expect(find.text('2000'), findsOneWidget);
    //expect(find.text('lastName'), findsOneWidget);
    //expect(find.text('avatar'), findsOneWidget);
  });
}
