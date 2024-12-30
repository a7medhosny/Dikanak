import 'package:dikanak/core/networking/auth_networking.dart';
import 'package:dio/dio.dart';

class Myrepo {
  final AuthNetworking authNetworking;

  Myrepo({required this.authNetworking});

  register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      Response response = await authNetworking.register(
          name: name, email: email, phone: phone, password: password);

      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          return {
            'success': true,
            'data': jsonData["data"],
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

  login({
    required String email,
    required String password,
  }) async {
    try {
      Response response =
          await authNetworking.login(email: email, password: password);

      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          return {
            'success': true,
            'data': jsonData["data"],
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
