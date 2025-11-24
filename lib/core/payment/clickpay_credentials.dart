// Auto-generated or env-driven credentials holder.
// IMPORTANT: Do not hardcode real production secrets here.
// Values are read from compile-time defines when provided (Codemagic/CI),
// and default to safe placeholders so builds don't fail if not injected.

class ClickPayCredentials {
  // Provide these via --dart-define in CI or generate this file in pre-build.
  static const String profileId = String.fromEnvironment('CLICKPAY_PROFILE_ID', defaultValue: '45213');
  static const String serverKey = String.fromEnvironment('CLICKPAY_SERVER_KEY', defaultValue: 'SLJNKKZBHD-J2RDKM222J-GMNTW229GM');
  static const String clientKey = String.fromEnvironment('CLICKPAY_CLIENT_KEY', defaultValue: 'C9KM9N-J2P6BP-BJ9V6T-2H9TBK');

  // Apple Pay merchant
  static const String appleMerchantId = String.fromEnvironment('APPLE_MERCHANT_ID', defaultValue: 'merchant.com.meshaal.meshaalcenter');
  static const String merchantDisplayName = String.fromEnvironment('MERCHANT_DISPLAY_NAME', defaultValue: 'Meshaal Center');

  // Region
  static const String countryCode = String.fromEnvironment('COUNTRY_CODE', defaultValue: 'SA');
  static const String currencyCode = String.fromEnvironment('CURRENCY_CODE', defaultValue: 'SAR');

  // Environment
  static const bool isTestMode = bool.fromEnvironment('CLICKPAY_TEST_MODE', defaultValue: false);
}
