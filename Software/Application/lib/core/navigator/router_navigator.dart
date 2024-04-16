import 'package:flutter/material.dart';
import 'package:generic_project/core/navigator/application_routes.dart';
import 'package:generic_project/features/dashboard/presentation/user_interfaces/dashboard_ui.dart';
import 'package:generic_project/features/dashboard/presentation/user_interfaces/impacts_ui.dart';
import 'package:generic_project/features/dashboard/presentation/user_interfaces/temprature_ui.dart';
import 'package:generic_project/features/splash/presentation/user_interfaces/splash_ui.dart';

class RouterNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static final RouteObserver<ModalRoute> routeObserver =
      RouteObserver<ModalRoute>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case  ApplicationRoutes.dashboardScreen:
      return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case ApplicationRoutes.temperatureScreen:
      return MaterialPageRoute(builder: (_) => const TempratureScreen());

      case ApplicationRoutes.impactsScreen:
      return MaterialPageRoute(builder: (_) => const ImpactsScreen());

      default:
      return MaterialPageRoute(builder: (_)=> const DashboardScreen());
      
/*
      case ApplicationRoutes.splashScreen:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
      return MaterialPageRoute(builder: (_)=> const SplashScreen());
*/
    }
  }
}
