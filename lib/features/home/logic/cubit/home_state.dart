part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

//Banners States
final class GetBannersLoading extends HomeState {}

final class GetBannersSucess extends HomeState {
  final List<BannerModel> banners;
  GetBannersSucess({required this.banners});
}

final class GetBannersFailure extends HomeState {
  final String message;

  GetBannersFailure(this.message);
}

//Categories States

final class GetCategoriesLoading extends HomeState {}

final class GetCategoriesSucess extends HomeState {
  final List<CategoryModel> categories;
  GetCategoriesSucess({required this.categories});
}

final class GetCategoriesFailure extends HomeState {
  final String message;

  GetCategoriesFailure(this.message);
}

final class GetProductsLoading extends HomeState {}

final class GetProductsSucess extends HomeState {
  final List<ProductModel> products;
  GetProductsSucess({required this.products});
}

final class GetProductsFailure extends HomeState {
  final String message;

  GetProductsFailure(this.message);
}

final class FilterProductsSucess extends HomeState {
  final List<ProductModel> filterProducts;
  FilterProductsSucess({required this.filterProducts});
}

final class UpdateFavoritesSucess extends HomeState {}

final class UpdateFavoritesFailure extends HomeState {
  final String message;

  UpdateFavoritesFailure(this.message);
}

final class GetFavoritesLoading extends HomeState {}

final class GetFavoritesSucess extends HomeState {
  final List<FavoriteProductModel> favorites;
  GetFavoritesSucess({required this.favorites});
}

final class GetFavoritesFailure extends HomeState {
  final String message;

  GetFavoritesFailure(this.message);
}
