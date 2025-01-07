import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:dikanak/core/networking/home_networking.dart';
import 'package:dikanak/features/home/data/repo/home_repo.dart';
import 'package:dikanak/features/home/logic/cubit/home_cubit.dart';
import 'package:dikanak/core/networking/auth_networking.dart';
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

  // Register HomeNetworking
  getIt.registerLazySingleton<HomeNetworking>(
      () => HomeNetworking(dio: getIt<Dio>()));

  // Register HomeRepo
  getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepo(homeNetworking: getIt<HomeNetworking>()));

  // Register HomeCubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));


}
