import 'package:dikanak/core/networking/home_networking.dart';
import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/data/model/category_model.dart';
import 'package:dikanak/features/home/data/model/favorite_product_model.dart';
import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeRepo {
  final HomeNetworking homeNetworking;

  HomeRepo({required this.homeNetworking});
  getBannerData() async {
    try {
      Response response = await homeNetworking.getBannerData();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          List<BannerModel> banners = (jsonData['data'] as List)
              .map((item) => BannerModel.fromJson(item))
              .toList();
          return {
            'success': true,
            'data': banners,
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

  getCategories() async {
    try {
      Response response = await homeNetworking.getCategories();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          List<CategoryModel> Categories = (jsonData['data']['data'] as List)
              .map((item) => CategoryModel.fromJson(item))
              .toList();
          return {
            'success': true,
            'data': Categories,
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

  getProducts() async {
    try {
      Response response = await homeNetworking.getProducts();
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
          await homeNetworking.updateFavorites(productId: productId);
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
      Response response = await homeNetworking.getFavorites();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
     
          List<FavoriteProductModel> favorites = (jsonData['data']['data'] as List)
              .map((item) =>FavoriteProductModel.fromJson(item['product']))
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
