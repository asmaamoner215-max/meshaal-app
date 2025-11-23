import 'package:flutter/foundation.dart';
import 'package:flutter_clickpay_bridge/flutter_clickpay_bridge.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_clickpay_bridge/BaseBillingShippingInfo.dart';

// Create a copy of clickpay_credentials.example.dart named clickpay_credentials.dart
// and fill in your real keys. This file should NOT be committed.
import 'clickpay_credentials.dart' as secrets;

class ApplePayService {
  const ApplePayService();

  Future<PaymentResult> payWithApplePay({
    required double amount,
    required String cartDescription,
    BillingDetails? billing,
    String? cartId,
  }) async {
    final config = PaymentSdkConfigurationDetails(
      profileId: secrets.ClickPayCredentials.profileId,
      serverKey: secrets.ClickPayCredentials.serverKey,
      clientKey: secrets.ClickPayCredentials.clientKey,
      cartId: cartId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      cartDescription: cartDescription,
      merchantName: secrets.ClickPayCredentials.merchantDisplayName,
      screentTitle: 'الدفع عبر Apple Pay',
      amount: amount,
      currencyCode: secrets.ClickPayCredentials.currencyCode,
      merchantCountryCode: secrets.ClickPayCredentials.countryCode,
      billingDetails: billing,
    );

    // Sandbox/live
    try {
      // ignore: deprecated_member_use
      // Some versions expose isTestMode on PaymentSdkConfigurationDetails.
      // If not available, ClickPay environment configured in dashboard applies.
      // config.isTestMode = secrets.ClickPayCredentials.isTestMode;
    } catch (_) {}

    final completer = ValueNotifier<PaymentResult?>(null);

    await FlutterPaymentSdkBridge.startApplePayPayment(
      config,
      (event) {
        final status = event['status']?.toString();
        if (status == 'success') {
          completer.value = PaymentResult.success(
            transactionReference: event['transactionReference']?.toString(),
            raw: event,
          );
        } else if (status == 'error') {
          completer.value = PaymentResult.error(
            message: event['message']?.toString() ?? 'Payment failed',
            raw: event,
          );
        } else {
          // intermediate event; ignore
        }
      },
    );

    // Wait until result is set
    PaymentResult? result;
    while (result == null) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
      result = completer.value;
    }
    return result;
  }
}

class PaymentResult {
  final bool ok;
  final String? transactionReference;
  final String? message;
  final Map<String, dynamic>? raw;

  const PaymentResult._(this.ok, this.transactionReference, this.message, this.raw);

  factory PaymentResult.success({String? transactionReference, Map<String, dynamic>? raw}) =>
      PaymentResult._(true, transactionReference, null, raw);

  factory PaymentResult.error({required String message, Map<String, dynamic>? raw}) =>
      PaymentResult._(false, null, message, raw);
}
