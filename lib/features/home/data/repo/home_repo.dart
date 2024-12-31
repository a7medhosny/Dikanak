import 'package:dikanak/core/networking/home_networking.dart';
import 'package:dikanak/features/home/data/model/banner_model.dart';
import 'package:dikanak/features/home/data/model/category_model.dart';
import 'package:dio/dio.dart';

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
              .map((item) =>CategoryModel.fromJson(item))
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
}