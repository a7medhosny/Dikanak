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
        options: Options(headers: {'lang': 'en'}));
    return response;
  }
  getProducts() async {
    Response response = await dio.get("${baseUrl}home",
        options: Options(headers: {'lang': 'en'}));
    return response;
  }
}
