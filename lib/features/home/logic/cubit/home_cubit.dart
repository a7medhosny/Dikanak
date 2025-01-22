import 'package:bloc/bloc.dart';
import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/data/model/category_model.dart';
import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dikanak/features/home/data/repo/home_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../common/test.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  List<CategoryModel> categories = [];
  List<BannerModel> banners = [];
  List<ProductModel> filterProducts = [];

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
       cartStatus = {
          for (var product in products) product.id.toString(): product.inCart
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
  getFilterProducts(input) {
    filterProducts = products
        .where((product) => product.name
            .toLowerCase()
            .startsWith(input.toString().toLowerCase()))
        .toList();
    emit(FilterProductsSucess(filterProducts: filterProducts));
  }
}
