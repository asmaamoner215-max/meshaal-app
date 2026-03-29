class EndPoints {
  // Use http://10.0.2.2:8080/api if testing on Android Emulator
  // Use http://localhost:8080/api if testing on Windows Desktop
  static const baseUrl = 'https://mca.sa.com/api';
  static const imageBaseUrl = 'https://mca.sa.com/storage/';
  static const register = '/signup_api';
  static const getNationality = '/get_nationalities';
  static const postCarOrder = '/post_orders_car';
  static const payWithWalletSMS = '/pay_wallet_sms';
  static const requestPrice = '/get_order_price';
  static const login = '/post_login';
  static const myInvoices = '/my_invoices';
  static const myTravels = '/my_travels';
  static const providerOrders = '/provider_orders';
  static const orderData = '/order_data';
  static const updateData = '/update_data';
  static const getSettings = '/get_settings';
  static const userData = '/user_data';
  static const getServices = '/get_services';
  static const postOrdersServices = '/post_orders_services';
  static const changeStatus = '/change_status';
  static const changeDestination = '/change_destination';
  static const relationData = '/relation_data';
  static const acknowledgment = '/acknowledgment';
}
