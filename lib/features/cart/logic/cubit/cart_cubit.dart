import 'package:bloc/bloc.dart';
import 'package:dikanak/core/widgets/stripe_payment/payment_manager.dart';
import 'package:dikanak/features/cart/data/repo/cart_repo.dart';
import 'package:meta/meta.dart';

import '../../../common/test.dart';
import '../../../home/data/model/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());
  List<ProductModel> cartProducts = [];
  final CartRepo cartRepo;
  getCarts() async {
    emit(GetCartsLoading());
    try {
      var response = await cartRepo.getCarts();
      if (response['success'] == true) {
        cartProducts = response['data'];
        emit(GetCartSucess(cartProducts: cartProducts));
      } else {
        emit(GetCartFailure(response['message'] ?? 'Failed to get Carts'));
      }
    } catch (e) {
      emit(GetCartFailure(e.toString()));
    }
  }

  updateCart({required String productId}) async {
    // Toggle local state
    cartStatus[productId] = !(cartStatus[productId] ?? false);
    cartProducts = products
        .where((product) => cartStatus[product.id.toString()] == true)
        .toList();
    emit(UpdateCartSucess());

    // Sync with the server
    try {
      var response = await cartRepo.updateCart(productId: productId);
      if (response['success'] != true) {
        // Revert local state on failure
        cartStatus[productId] = !(cartStatus[productId] ?? false);
        emit(UpdateCartFailure(
            response['message'] ?? 'Failed to update favorites'));
      }
    } catch (e) {
      // Revert local state on error
      cartStatus[productId] = !(cartStatus[productId] ?? false);
      emit(UpdateCartFailure(e.toString()));
    }
  }

  Future<void> processPayment(
      {required int amount, required String currency}) async {
    print('Process pay');
    emit(PaymentLoading());
    try {
      await PaymentManager.makePayment(amount, currency);
      emit(PaymentSuccess());
    } catch (e) {
      String errorMes = "";
      if (e.toString().toLowerCase().contains('cancel')) {
        errorMes = "Canceled";
      } else {
        errorMes = "Payment failed";
      }
      emit(PaymentFailure(errorMes));
    }
  }
}
