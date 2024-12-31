import 'package:dikanak/core/DI/get_it.dart';
import 'package:dikanak/core/routing/routes.dart';
import 'package:dikanak/features/auth/logic/cubits/cubit/auth_cubit.dart';
import 'package:dikanak/features/auth/presention/screens/login_screen.dart';
import 'package:dikanak/features/auth/presention/screens/register_screen.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:dikanak/features/home/presention/screens/home_screen.dart';
import 'package:dikanak/features/layout/logic/cubits/cubit/layout_cubit.dart';
import 'package:dikanak/features/layout/presention/screens/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.onBoardingScreen:
      //   return MaterialPageRoute(builder: (_) =>OnboardingScreen());

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: LoginScreen(),
          ),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: RegisterScreen(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: HomeScreen(),
          ),
        );

      case Routes.layoutScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LayoutCubit(),
              ),
              BlocProvider(
                create: (context) => getIt<HomeCubit>(),
              ),
            ],
            child: LayoutScreen(),
          ),
        );
    }
  }
}
