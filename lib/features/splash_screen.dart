import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:dikanak/core/networking/consts.dart';
import 'package:dikanak/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? cachedToken = CacheNetwork.getCacheData(key: token);
    final String initialRoute =
        cachedToken != null ? Routes.layoutScreen : Routes.loginScreen;

    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(initialRoute);
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                'assets/images/logo.webp',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Developed by Ahmed Hosny',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
