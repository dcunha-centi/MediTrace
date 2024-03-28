import 'package:flutter/material.dart';
import 'package:generic_project/core/navigator/application_routes.dart';
import 'package:generic_project/features/home/presentation/user_interfaces/home_ui.dart';
import 'package:generic_project/features/splash/presentation/user_interfaces/splash_ui.dart';

class RouterNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static final RouteObserver<ModalRoute> routeObserver =
      RouteObserver<ModalRoute>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case  ApplicationRoutes.homeScreen:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
      return MaterialPageRoute(builder: (_)=> const SplashScreen());
    }
  }
}
