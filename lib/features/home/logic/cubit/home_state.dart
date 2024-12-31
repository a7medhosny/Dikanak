part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}

final class GetBannersSucess extends HomeState {
  final List<BannerModel> banners;
  GetBannersSucess({required this.banners});
}

final class GetBannersFailure extends HomeState {
  final String message;

  GetBannersFailure(this.message);
}
