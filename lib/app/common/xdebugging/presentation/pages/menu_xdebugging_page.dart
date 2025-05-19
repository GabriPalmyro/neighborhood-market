import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:neighborhood_market/app/common/router/app_navigator.dart';
import 'package:neighborhood_market/app/common/router/routes.dart';

class MenuXdebuggingPage extends StatelessWidget {
  const MenuXdebuggingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Endpoint'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                GetIt.I.get<AppNavigator>().pushRoute(Routes.debuggingEndpoint);
              },
            ),
            ListTile(
              leading: const Icon(Icons.deblur_outlined),
              title: const Text('Cubit'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                // Handle cubit tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.error),
              title: const Text('Exceptions'),
              trailing: const Icon(Icons.keyboard_arrow_right_outlined),
              onTap: () {
                GetIt.I.get<AppNavigator>().pushRoute(Routes.exceptionInterceptor);
              },
            ),
          ],
        ),
      ),
    );
  }
}
