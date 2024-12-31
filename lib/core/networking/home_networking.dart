import 'package:dikanak/core/networking/consts.dart';
import 'package:dio/dio.dart';

class HomeNetworking {
  final Dio dio;

  HomeNetworking({required this.dio});

  getBannerData() async {
    Response response = await dio.get("${baseUrl}banners");
    return response;
  }
}
