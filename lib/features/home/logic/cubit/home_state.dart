part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}
//Banners States
final class GetBannersSucess extends HomeState {
  final List<BannerModel> banners;
  GetBannersSucess({required this.banners});
}

final class GetBannersFailure extends HomeState {
  final String message;

  GetBannersFailure(this.message);
}
//Categories States
final class GetCategoriesSucess extends HomeState {
  final List<CategoryModel> categories;
  GetCategoriesSucess({required this.categories});
}

final class GetCategoriesFailure extends HomeState {
  final String message;

  GetCategoriesFailure(this.message);
}
final class GetProductsSucess extends HomeState {
  final List<ProductModel> products;
  GetProductsSucess({required this.products});
}

final class GetProductsFailure extends HomeState {
  final String message;

  GetProductsFailure(this.message);
}
