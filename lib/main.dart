import 'package:dikanak/core/DI/get_it.dart';
import 'package:dikanak/core/routing/app_routing.dart';
import 'package:dikanak/core/routing/routes.dart';
import 'package:flutter/material.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
final AppRouter appRouter=AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.layoutScreen,
        onGenerateRoute: (settings) => appRouter.generateRoute(settings),
    );
  }
}
