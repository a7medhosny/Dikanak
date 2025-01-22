import 'package:flutter/material.dart';
import 'package:dikanak/core/DI/get_it.dart';
import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:dikanak/core/networking/consts.dart';
import 'package:dikanak/core/routing/app_routing.dart';
import 'package:dikanak/core/routing/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
   

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: _appRouter.generateRoute,
    );
  }
}
