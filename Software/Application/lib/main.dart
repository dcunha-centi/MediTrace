
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_project/core/cubits/application_cubit_observer.dart';

import 'core/navigator/router_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = ApplicationCubitObserver();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTrace',
      debugShowCheckedModeBanner: false,
      navigatorKey: RouterNavigator.navigatorKey,
      navigatorObservers: [RouterNavigator.routeObserver],
      onGenerateRoute: RouterNavigator.generateRoute,
    );
  }
}
