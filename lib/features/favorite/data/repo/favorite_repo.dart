import 'package:dikanak/core/networking/favorite_networking.dart';
import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dio/dio.dart';

import '../model/favorite_product_model.dart';

class FavoriteRepo {
  // final HomeNetworking homeNetworking;
  final FavoriteNetworking favoriteNetworking;
  FavoriteRepo({required this.favoriteNetworking});

  getProducts() async {
    try {
      Response response = await favoriteNetworking.getProducts();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          List<ProductModel> products = (jsonData['data']['products'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList();
          return {
            'success': true,
            'data': products,
          };
        } else {
          return {'success': false, 'message': jsonData["message"]};
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: ${e.toString()}'
      };
    }
  }

  updateFavorites({required String productId}) async {
    try {
      Response response =
          await favoriteNetworking.updateFavorites(productId: productId);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          return {
            'success': true,
          };
        } else {
          return {'success': false, 'message': jsonData["message"]};
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: ${e.toString()}'
      };
    }
  }

  getFavorites() async {
    try {
      Response response = await favoriteNetworking.getFavorites();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          List<FavoriteProductModel> favorites =
              (jsonData['data']['data'] as List)
                  .map((item) => FavoriteProductModel.fromJson(item['product']))
                  .toList();
          return {
            'success': true,
            'data': favorites,
          };
        } else {
          return {'success': false, 'message': jsonData["message"]};
        }
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An unexpected error occurred: ${e.toString()}'
      };
    }
  }
}
