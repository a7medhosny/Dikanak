import 'package:dikanak/core/widgets/stripe_payment/stripe_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManager {
  static Future<void> makePayment(num amount, String currency) async {
    try {
      String clientSecret =
          await _getClientSecret((amount * 100).toString(), currency);

      // Initialize payment sheet
      await _initializePaymentSheet(clientSecret);

      // Present payment sheet to user
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      // Handle Stripe-specific exceptions
      throw Exception("Stripe error: ${e.error.localizedMessage}");
    } on DioException catch (e) {
      // Handle network or API-related errors
      if (e.response != null) {
        throw Exception(
            "Payment failed: ${e.response?.data['error']?['message'] ?? 'Unknown error'}");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      // Handle unexpected errors
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "ahmed",
        ),
      );
    } on StripeException catch (e) {
      throw Exception("Stripe initialization error: ${e.error.localizedMessage}");
    } catch (e) {
      throw Exception("Failed to initialize payment sheet: ${e.toString()}");
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();

    try {
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Keys.secretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'amount': amount,
          'currency': currency,
        },
      );

      if (response.statusCode == 200) {
        return response.data["client_secret"];
      } else {
        throw Exception(
            "Failed to create payment intent: ${response.data['error']?['message'] ?? 'Unknown error'}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            "API error: ${e.response?.data['error']?['message'] ?? 'Unknown error'}");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error while fetching client secret: ${e.toString()}");
    }
  }
}
