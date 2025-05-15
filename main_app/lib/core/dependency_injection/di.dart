// core/dependency_injection/di.dart

import 'package:e_commerce_app/core/databases/remote/end_points.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:e_commerce_app/core/databases/local/favorite_color.dart';
import 'package:e_commerce_app/core/databases/local/theme_mode.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppDependencies {
  // static ApiKey? _apiKey;
  // static EndPoints? _endPoints;

  // static Future<void> init() async {
  //   _apiKey = await ApiKey.getInstance();
  //   _endPoints = EndPoints(_apiKey!);
  // }

  // static ApiKey get apiKey {
  //   if (_apiKey == null) {
  //     throw Exception(
  //       'ApiKey not initialized. Call AppDependencies.init() first.',
  //     );
  //   }
  //   return _apiKey!;
  // }

  // static EndPoints get endPoints {
  //   if (_endPoints == null) {
  //     throw Exception(
  //       'EndPoints not initialized. Call AppDependencies.init() first.',
  //     );
  //   }
  //   return _endPoints!;
  // }

  // providers الخاصة بالـ ChangeNotifier (مزودي الحالة (State Providers))
  static List<SingleChildWidget> get providerProviders {
    return [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      // ممكن تضيف هنا FavoriteColor و ThemeMode لو بتستخدمهم كمزودين برضه
    ];
  }

  // blocProviders الخاصة بالـ Cubit أو Bloc
  static List<BlocProvider> get blocProviders {
    return [
      BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      BlocProvider<PrimaryColorCubit>(create: (_) => PrimaryColorCubit()),
    ];
  }
}
