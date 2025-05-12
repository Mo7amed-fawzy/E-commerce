import 'package:e_commerce_app/app/app.dart';
import 'package:e_commerce_app/core/databases/local/favorite_color.dart';
import 'package:e_commerce_app/core/databases/local/theme_mode.dart';
import 'package:e_commerce_app/core/providers/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحديد مكان تخزين البيانات
  final directory = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(
              directory.path,
            ), // استخدم المسار كـ HydratedStorageDirectory
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => PrimaryColorCubit())],
        child: const MyApp(),
      ),
    );
  }
}
