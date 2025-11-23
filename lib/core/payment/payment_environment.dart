/// Simple runtime environment toggle for payment flows.
/// Extend later to load from secure storage or remote config.
class PaymentEnvironment {
  PaymentEnvironment._();

  static bool _testMode = true; // default stays sandbox

  static bool get isTestMode => _testMode;

  static void setTestMode(bool value) {
    _testMode = value;
  }
}
