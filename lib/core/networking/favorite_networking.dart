import 'package:dikanak/core/networking/consts.dart';
import 'package:dio/dio.dart';

class FavoriteNetworking {
  final Dio dio;

  FavoriteNetworking({required this.dio});
  updateFavorites({required String productId}) async {
    Response response = await dio.post("${baseUrl}favorites",
        data: {"product_id": productId}, options: Options(headers: headers));
    return response;
  }

  getFavorites() async {
    Response response = await dio.get("${baseUrl}favorites",
        options: Options(headers: headers));
    return response;
  }
  getProducts() async {
    Response response =
        await dio.get("${baseUrl}home", options: Options(headers: headers));
    return response;
  }
}
