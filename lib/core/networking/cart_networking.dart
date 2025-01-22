import 'package:dikanak/core/networking/consts.dart';
import 'package:dio/dio.dart';

class CartNetworking {
  final Dio dio;

  CartNetworking({required this.dio});
  getCarts() async {
    Response response =
        await dio.get("${baseUrl}carts", options: Options(headers: headers));
    return response;
  }

  updateCart({required String productId}) async {
    Response response = await dio.post("${baseUrl}carts",
        data: {"product_id": productId}, options: Options(headers: headers));
    return response;
  }
}
