import 'package:dio/dio.dart';
import 'package:dikanak/core/networking/consts.dart';

class AuthNetworking {
  final Dio dio;

  AuthNetworking({required this.dio});

  // Common headers for all requests

  /// Registers a new user with the provided details.
  Future<Response> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final response = await dio.post(
      '${baseUrl}register',
      data: {
        "name": name,
        "email": email,
        "phone": phone,
        "password": password,
      },
    );
    return response;
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      '${baseUrl}register',
      data: {
        "email": email,
        "password": password,
      },
    );
    return response;
  }
}
