import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:neighborhood_market/app/common/xdebugging/features/error/domain/interceptors/exceptions_interceptor.dart';
import 'package:neighborhood_market/app/core/app_strings.dart';
import 'package:neighborhood_market/app/utils/errors/payment_exceptions.dart';

@Singleton()
class StripeService {
  StripeService() {
    _init();
  }

  void _init() {
    final publishKey = dotenv.env[AppStrings.stripeKey] ?? '';
    final merchantId = dotenv.env[AppStrings.stripeMerchantId] ?? '';
    Stripe.publishableKey = publishKey;
    Stripe.merchantIdentifier = merchantId;
    Stripe.instance.applySettings();
  }

  final exceptionInterceptor = ExceptionInterceptor();

  Future<PaymentSheetPaymentOption?> makePayment(
    String clientSecret,
  ) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          customFlow: false,
          style: ThemeMode.light,
          merchantDisplayName: AppStrings.title,
          applePay: const PaymentSheetApplePay(
            buttonType: PlatformButtonType.buy,
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: !kReleaseMode,
          ),
        ),
      );
    } catch (e, s) {
      exceptionInterceptor.saveException(
        exceptionTime: DateTime.now(),
        exceptionMessage: e.toString(),
        stackTrace: s.toString(),
        contextInfo: 'PaymentSheet Initialization',
      );
      throw const PaymentDialogException();
    }

    try {
      final response = await Stripe.instance.presentPaymentSheet();
      return response;
    } catch (e, s) {
      if ((e as StripeException).error.message == 'The payment flow has been canceled') {
        throw const PaymentDialogDismissed();
      }

      exceptionInterceptor.saveException(
        exceptionTime: DateTime.now(),
        exceptionMessage: e.error.message!,
        stackTrace: s.toString(),
        contextInfo: 'PaymentSheet Presentation',
      );

      throw const PaymentDialogException();
    }
  }
}
