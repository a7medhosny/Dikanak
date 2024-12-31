import 'package:dikanak/core/DI/get_it.dart';
import 'package:dikanak/core/routing/app_routing.dart';
import 'package:dikanak/core/routing/routes.dart';
import 'package:dikanak/features/auth/logic/cubits/cubit/auth_cubit.dart';
import 'package:dikanak/features/auth/presention/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
AppRouter appRouter=AppRouter();
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
