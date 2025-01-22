part of 'favorite_cubit.dart';

@immutable
sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class UpdateFavoritesSucess extends FavoriteState {}

final class UpdateFavoritesFailure extends FavoriteState {
  final String message;

  UpdateFavoritesFailure(this.message);
}

final class GetFavoritesLoading extends FavoriteState {}

final class GetFavoritesSucess extends FavoriteState {
  final List<FavoriteProductModel> favorites;
  GetFavoritesSucess({required this.favorites});
}

final class GetFavoritesFailure extends FavoriteState {
  final String message;

  GetFavoritesFailure(this.message);
}