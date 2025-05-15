import 'package:e_commerce_app/app/app.dart';
import 'package:e_commerce_app/core/dependency_injection/di.dart';
import 'package:e_commerce_app/core/dependency_injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(directory.path),
  );

  await setupServiceLocator();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...AppDependencies.providerProviders],
      child: MultiBlocProvider(
        providers: [...AppDependencies.blocProviders],
        child: const MyApp(),
      ),
    );
  }
}
