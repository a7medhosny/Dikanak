import 'package:dikanak/core/networking/consts.dart';
import 'package:dio/dio.dart';

class HomeNetworking {
  final Dio dio;

  HomeNetworking({required this.dio});

  getBannerData() async {
    Response response = await dio.get("${baseUrl}banners");
    return response;
  }


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

  // updateFavorites({required String productId}) async {
  //   Response response = await dio.post("${baseUrl}favorites",
  //       data: {"product_id": productId}, options: Options(headers: headers));
  //   return response;
  // }

  // getFavorites() async {
  //   Response response = await dio.get("${baseUrl}favorites",
  //       options: Options(headers: headers));
  //   return response;
  // }

  getCarts() async {
    Response response = await dio.get("${baseUrl}carts",
        options: Options(headers: headers));
    return response;
  }
  updateCart({required String productId}) async {
    Response response = await dio.post("${baseUrl}carts",data: {
      "product_id": productId
    },
        options: Options(headers: headers));
    return response;
  }
}
