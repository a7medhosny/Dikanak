import 'package:dikanak/core/networking/cart_networking.dart';
import 'package:dikanak/features/home/data/model/product_model.dart';
import 'package:dio/dio.dart';


class CartRepo {
  final CartNetworking cartNetworking;

  CartRepo({required this.cartNetworking});
  getCarts() async {
    try {
      Response response = await cartNetworking.getCarts();
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          List<ProductModel> cartItems =
              (jsonData['data']['cart_items'] as List)
                  .map((item) => ProductModel.fromJson(item['product']))
                  .toList();
          return {
            'success': true,
            'data': cartItems,
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

  updateCart({required String productId}) async {
    try {
      Response response = await cartNetworking.updateCart(productId: productId);
      if (response.statusCode == 200) {
        var jsonData = response.data;
        if (jsonData['status'] == true) {
          return {
            'success': true,
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
