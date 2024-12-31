import 'package:dikanak/core/networking/home_networking.dart';
import 'package:dikanak/features/home/data/repo/HomeRepo.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:dikanak/core/networking/auth_networking.dart';
import 'package:dio/dio.dart';

import '../../features/auth/data/repo/myrepo.dart';
import '../../features/auth/logic/cubits/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  // Register Dio instance
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register AuthNetworking
  getIt.registerLazySingleton<AuthNetworking>(
      () => AuthNetworking(dio: getIt<Dio>()));

  // Register Myrepo
  getIt.registerLazySingleton<Myrepo>(
      () => Myrepo(authNetworking: getIt<AuthNetworking>()));

  // Register AuthCubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<Myrepo>()));

  // Register AuthNetworking
  getIt.registerLazySingleton<HomeNetworking>(
      () => HomeNetworking(dio: getIt<Dio>()));

  // Register Myrepo
  getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepo( homeNetworking:getIt<HomeNetworking>()));

  // Register AuthCubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));
}
