import 'package:bloc/bloc.dart';
import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/data/model/category_model.dart';
import 'package:dikanak/features/home/data/model/favorite_product_model.dart';
import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dikanak/features/home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  List<CategoryModel> categories = [];
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  List<FavoriteProductModel> favorites = [];
  List<ProductModel> filterProducts = [];
  Map<String, bool> favoritesStatus = {}; // Local state for favorites

  HomeCubit(this.homeRepo) : super(HomeInitial());
  getBannerData() async {
    emit(HomeLoading());
    try {
      var response = await homeRepo.getBannerData();
      if (response['success'] == true) {
        banners = response['data'];
        emit(GetBannersSucess(banners: banners));
      } else {
        emit(GetBannersFailure(response['message'] ?? 'Get Banners Failure'));
      }
    } catch (e) {
      emit(GetBannersFailure(e.toString()));
    }
  }

  getCategories() async {
    emit(GetCategoriesLoading());
    try {
      var response = await homeRepo.getCategories();
      if (response['success'] == true) {
        categories = response['data'];
        emit(GetCategoriesSucess(categories: categories));
      } else {
        emit(
            GetCategoriesFailure(response['message'] ?? 'Get Banners Failure'));
      }
    } catch (e) {
      emit(GetCategoriesFailure(e.toString()));
    }
  }

  getProducts() async {
    emit(GetProductsLoading());
    try {
      var response = await homeRepo.getProducts();
      if (response['success'] == true) {
        products = response['data'];

        // Initialize local favorites state
        favoritesStatus = {
          for (var product in products)
            product.id.toString(): product.inFavorites
        };

        emit(GetProductsSucess(products: products));
      } else {
        emit(GetProductsFailure(
            response['message'] ?? 'Failed to get products'));
      }
    } catch (e) {
      emit(GetProductsFailure(e.toString()));
    }
  }

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

    // getFavorites();
    // Sync with the server
    try {
      var response = await homeRepo.updateFavorites(productId: productId);
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
    // emit(GetFavoritesLoading());
    try {
      var response = await homeRepo.getFavorites();
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

  getFilterProducts(input) {
    filterProducts = products
        .where((product) => product.name!
            .toLowerCase()
            .startsWith(input.toString().toLowerCase()))
        .toList();
    emit(FilterProductsSucess(filterProducts: filterProducts));
  }
}
