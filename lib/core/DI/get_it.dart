import 'package:dikanak/core/networking/cart_networking.dart';
import 'package:dikanak/core/networking/favorite_networking.dart';
import 'package:dikanak/core/networking/person_networking.dart';
import 'package:dikanak/features/cart/data/repo/cart_repo.dart';
import 'package:dikanak/features/cart/logic/cubit/cart_cubit.dart';
import 'package:dikanak/features/favorite/data/repo/favorite_repo.dart';
import 'package:dikanak/features/favorite/logic/cubit/favorite_cubit.dart';
import 'package:dikanak/features/person/data/repo/person_repo.dart';
import 'package:dikanak/features/person/logic/cubit/person_cubit.dart';
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
  // Register Dio instance for HTTP requests
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register AuthNetworking for authentication-related networking
  getIt.registerLazySingleton<AuthNetworking>(
      () => AuthNetworking(dio: getIt<Dio>()));

  // Register Myrepo as the authentication repository
  getIt.registerLazySingleton<Myrepo>(
      () => Myrepo(authNetworking: getIt<AuthNetworking>()));

  // Register AuthCubit for managing authentication state
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<Myrepo>()));

  // Register HomeNetworking for home-related networking
  getIt.registerLazySingleton<HomeNetworking>(
      () => HomeNetworking(dio: getIt<Dio>()));

  // Register HomeRepo as the repository for home-related data
  getIt.registerLazySingleton<HomeRepo>(
      () => HomeRepo(homeNetworking: getIt<HomeNetworking>()));

  // Register HomeCubit for managing home state
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));

  // Register FavoriteNetworking for favorite-related networking
  getIt.registerLazySingleton<FavoriteNetworking>(
      () => FavoriteNetworking(dio: getIt<Dio>()));

  // Register FavoriteRepo as the repository for favorite data
  getIt.registerLazySingleton<FavoriteRepo>(
      () => FavoriteRepo(favoriteNetworking: getIt<FavoriteNetworking>()));

  // Register FavoriteCubit for managing favorite state
  getIt.registerFactory<FavoriteCubit>(() => FavoriteCubit(getIt<FavoriteRepo>()));

  // Register CartNetworking for cart-related networking
  getIt.registerLazySingleton<CartNetworking>(
      () => CartNetworking(dio: getIt<Dio>()));

  // Register CartRepo as the repository for cart data
  getIt.registerLazySingleton<CartRepo>(
      () => CartRepo(cartNetworking: getIt<CartNetworking>()));

  // Register CartCubit for managing cart state
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<CartRepo>()));

/////////////////person/////////////////
  getIt.registerLazySingleton<PersonNetworking>(
      () => PersonNetworking(dio: getIt<Dio>()));

  // Register CartRepo as the repository for cart data
  getIt.registerLazySingleton<PersonRepo>(
      () => PersonRepo(personNetworking: getIt<PersonNetworking>()));

  // Register CartCubit for managing cart state
  getIt.registerFactory<PersonCubit>(() => PersonCubit(getIt<PersonRepo>()));
}
