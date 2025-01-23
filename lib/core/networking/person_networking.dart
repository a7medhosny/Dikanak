import 'package:dikanak/core/networking/consts.dart';
import 'package:dio/dio.dart';

class PersonNetworking {
  final Dio dio;

  PersonNetworking({required this.dio});
  getPersonInfo() async {
    Response response =
        await dio.get("${baseUrl}profile", options: Options(headers: headers));
    return response;
  }
}
