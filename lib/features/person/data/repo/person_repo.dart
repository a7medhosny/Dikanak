import 'package:dikanak/core/networking/person_networking.dart';
import 'package:dikanak/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

class PersonRepo {
  final PersonNetworking personNetworking;

  PersonRepo({required this.personNetworking});
  getPersonInfo() async {
    try {
      Response response = await personNetworking.getPersonInfo();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          UserModel person = UserModel.fromJson(jsonData['data']);
          return {
            'success': true,
            'data': person,
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
