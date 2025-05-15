abstract class ApiKey {
  static const String myUri01 = 'http://192.168.1.9:3020';
  // static const String baseUrl = 'https://api.example.com/';
  static const String http = 'http://localhost:3020';
  static const String httpCinfig = 'http://192.168.1.9:3020';
  static const String signUpUrl = '$httpCinfig/api/signup';
  static const String signInUrl = '$httpCinfig/api/signin';
  static const String isValidToken = '$httpCinfig/isvalidtoken';
  static const String checkToken = '$httpCinfig/';
  static const String adminAddProduct = '$httpCinfig/admin/add-product';
  static const String adminGetProducts = '$httpCinfig/admin/get-products';
  static const String adminDeletProducts = '$httpCinfig/admin/delete-products';
  static const String getProducts = '$httpCinfig/api/get-products';
  static const String search = '$httpCinfig/api/get-products/search/';
  static const String rateProduct = '$httpCinfig/api/rate-product';
  static const String deelOfTheDay = '$httpCinfig/api/deal-of-the-day';
  static const String addToCart = '$httpCinfig/api/add-to-cart';
  static const String removeFromCart = '$httpCinfig/api/remove-to-cart';
  static const String saveUserAddress = '$httpCinfig/api/save-user-address';
  static const String setOrder = '$httpCinfig/api/order';
  static const String myOrders = '$httpCinfig/api/my-orders';
  static const String getAllProducts = '$httpCinfig/api/all-orders-admin';
  static const String updateOrderStatus =
      '$httpCinfig/admin/update-order-status';
  static const String getAdminAnalytics = '$httpCinfig/admin/analytics';
  static const String getUserInfo = '$httpCinfig/api/get-user-info';
}

// import 'dart:io';

// class ApiKey {
//   final String baseUrl;

//   ApiKey._(this.baseUrl);

//   static ApiKey? _instance;

//   static Future<ApiKey> getInstance() async {
//     if (_instance != null) return _instance!;

//     const bool isProduction = false;

//     String ip = 'localhost';

//     if (!isProduction) {
//       final interfaces = await NetworkInterface.list(
//         includeLoopback: false,
//         type: InternetAddressType.IPv4,
//       );

//       for (var interface in interfaces) {
//         for (var addr in interface.addresses) {
//           if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
//             ip = addr.address;
//             break;
//           }
//         }
//         if (ip != 'localhost') break;
//       }
//     }

//     final baseUrl =
//         isProduction ? 'https://api.yourapp.com' : 'http://$ip:3020';

//     _instance = ApiKey._(baseUrl);
//     return _instance!;
//   }
// }

// class EndPoints {
//   final ApiKey apiKey;

//   EndPoints(this.apiKey);

//   String get baseUrl => apiKey.baseUrl;
//   String get signUpUrl => '$baseUrl/api/signup';
//   String get signInUrl => '$baseUrl/api/signin';
//   String get isValidToken => '$baseUrl/isvalidtoken';
//   String get checkToken => '$baseUrl/';
//   String get adminAddProduct => '$baseUrl/admin/add-product';
//   String get adminGetProducts => '$baseUrl/admin/get-products';
//   String get adminDeletProducts => '$baseUrl/admin/delete-products';
//   String get getProducts => '$baseUrl/api/get-products';
//   String get search => '$baseUrl/api/get-products/search/';
//   String get rateProduct => '$baseUrl/api/rate-product';
//   String get deelOfTheDay => '$baseUrl/api/deal-of-the-day';
//   String get addToCart => '$baseUrl/api/add-to-cart';
//   String get removeFromCart => '$baseUrl/api/remove-to-cart';
//   String get saveUserAddress => '$baseUrl/api/save-user-address';
//   String get setOrder => '$baseUrl/api/order';
//   String get myOrders => '$baseUrl/api/my-orders';
//   String get getAllProducts => '$baseUrl/api/all-orders-admin';
//   String get updateOrderStatus => '$baseUrl/admin/update-order-status';
//   String get getAdminAnalytics => '$baseUrl/admin/analytics';
//   String get getUserInfo => '$baseUrl/api/get-user-info';
// }
