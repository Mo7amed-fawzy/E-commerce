// core/dependency_injection/service_locator.dart

import 'package:e_commerce_app/core/services/auth_service.dart';
import 'package:e_commerce_app/core/services/home_service.dart';
import 'package:e_commerce_app/core/services/product_servic.dart';
import 'package:get_it/get_it.dart';
import 'package:e_commerce_app/core/databases/remote/end_points.dart';
import 'package:e_commerce_app/core/services/admin_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // final apiKey = await ApiKey.getInstance();
  // final endPoints = EndPoints(apiKey);

  // getIt.registerSingleton<EndPoints>(endPoints);
  getIt.registerLazySingleton<AdminService>(() => AdminService());
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<HomeService>(() => HomeService());
  getIt.registerLazySingleton<ProductServices>(() => ProductServices());
}
