abstract class ApiKey {
  static const String myUri01 = 'http://192.168.1.7:3020';
  // static const String baseUrl = 'https://api.example.com/';
  static const String http = 'http://localhost:3020';
  static const String httpCinfig = 'http://192.168.1.7:3020';
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
