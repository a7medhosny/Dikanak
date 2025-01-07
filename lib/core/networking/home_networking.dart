import 'package:dikanak/core/helpers/local_storage/shared_preferences.dart';
import 'package:dikanak/core/networking/consts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HomeNetworking {
  final Dio dio;

  HomeNetworking({required this.dio});

  getBannerData() async {
    Response response = await dio.get("${baseUrl}banners");
    return response;
  }

  var headers = {
    'lang': 'en',
    'Authorization': CacheNetwork.getCacheData(key: token)
  };
  getCategories() async {
    Response response = await dio.get("${baseUrl}categories",
        options: Options(headers: headers));
    return response;
  }

  getProducts() async {
    Response response =
        await dio.get("${baseUrl}home", options: Options(headers: headers));
    return response;
  }

  updateFavorites({required String productId}) async {
    Response response = await dio.post("${baseUrl}favorites",
        data: {"product_id": productId}, options: Options(headers: headers));
    return response;
  }

  getFavorites() async {
    Response response = await dio.get("${baseUrl}favorites",
        options: Options(headers:headers));
    return response;
  }
}
