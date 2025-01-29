import 'package:dikanak/core/widgets/stripe_payment/stripe_keys.dart';
import 'package:flutter/material.dart';
import 'package:dikanak/core/DI/get_it.dart';
import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:dikanak/core/routing/app_routing.dart';
import 'package:dikanak/core/routing/routes.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.cacheInitialization();
  setup();
  Stripe.publishableKey = Keys.publishableKey;

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
