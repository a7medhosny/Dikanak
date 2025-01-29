part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartsLoading extends CartState {}

final class UpdateCartSucess extends CartState {}

final class UpdateCartFailure extends CartState {
  final String message;

  UpdateCartFailure(this.message);
}

final class GetCartSucess extends CartState {
  final List<ProductModel> cartProducts;
  GetCartSucess({required this.cartProducts});
}

final class GetCartFailure extends CartState {
  final String message;

  GetCartFailure(this.message);
}

final class PaymentLoading extends CartState {}

final class PaymentSuccess extends CartState {}

final class PaymentFailure extends CartState {
  final String message;
  PaymentFailure(this.message);
}
