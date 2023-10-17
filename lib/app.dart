import 'package:flutter/material.dart';
import 'package:flutter_app_architecture/data/repository/resource_repository_fake_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'domain/repository/resource_repository.dart';
import 'notifier/resource.dart';

void main() {

  runApp(const ProviderScope(child: ResourceScreen()));
}

class ResourceScreen extends ConsumerStatefulWidget {
  const ResourceScreen({super.key});

  @override
  ConsumerState createState() => _ResourceState();
}

class _ResourceState extends ConsumerState<ResourceScreen> {

  final ResourceRepository resourceRepository = ResourceRepositoryFakeImpl();

  @override
  Widget build(BuildContext context) {
    final resourceAsync = ref.watch(resourceAsyncNotifierProviderFamily(resourceRepository));

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                TextButton(
                    onPressed: () {
                      ref.watch(resourceAsyncNotifierProviderFamily(resourceRepository).notifier).findOne(1);
                    },
                    child: const Text('Fetch Data')),
                Stack(
                  children: [
                    if(resourceAsync.isLoading) ...[const CircularProgressIndicator()]
                    else if(resourceAsync.hasError) ...[Text(resourceAsync.error.toString())]
                    else if(!resourceAsync.isLoading && resourceAsync.value != null) ...[
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                const Text('id \t\t\t\t'),
                                Text('${resourceAsync.value!.id}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('name \t\t\t\t'),
                                Text(resourceAsync.value!.name),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('year \t\t\t\t'),
                                Text('${resourceAsync.value!.year}'),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('color \t\t\t\t'),
                                Text(resourceAsync.value!.color),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('pantoneValue'),
                                Text(resourceAsync.value!.pantoneValue),
                              ],
                            ),
                          ],
                        ),
                      )
                    ] ,
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
