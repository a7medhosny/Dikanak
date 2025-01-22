import 'package:bloc/bloc.dart';
import 'package:dikanak/features/favorite/data/repo/favorite_repo.dart';
import 'package:meta/meta.dart';

import '../../../common/test.dart';
import '../../data/model/favorite_product_model.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this.favoriteRepo) : super(FavoriteInitial());
  List<FavoriteProductModel> favorites = [];
  // Map<String, bool> favoritesStatus = {}; // Local state for favorites
  final FavoriteRepo favoriteRepo;


  // Update favorites locally and sync with the server
  updateFavorites({required String productId}) async {
    // Toggle local state
    favoritesStatus[productId] = !(favoritesStatus[productId] ?? false);
    favorites = products
        .where((product) => (favoritesStatus[product.id.toString()] == true &&
            !favorites
                .contains(FavoriteProductModel.fromJson(product.toJson()))))
        .map((product) => FavoriteProductModel.fromJson(product.toJson()))
        .toList();

    emit(UpdateFavoritesSucess());

    try {
      var response = await favoriteRepo.updateFavorites(productId: productId);
      if (response['success'] != true) {
        // Revert local state on failure
        favoritesStatus[productId] = !(favoritesStatus[productId] ?? false);
        emit(UpdateFavoritesFailure(
            response['message'] ?? 'Failed to update favorites'));
      }
    } catch (e) {
      // Revert local state on error
      favoritesStatus[productId] = !(favoritesStatus[productId] ?? false);
      emit(UpdateFavoritesFailure(e.toString()));
    }
  }

  getFavorites() async {
    emit(GetFavoritesLoading());
    try {
      var response = await favoriteRepo.getFavorites();
      if (response['success'] == true) {
        favorites = response['data'];
        emit(GetFavoritesSucess(favorites: favorites));
      } else {
        emit(GetFavoritesFailure(
            response['message'] ?? 'Failed to get products'));
      }
    } catch (e) {
      emit(GetFavoritesFailure(e.toString()));
    }
  }
}
