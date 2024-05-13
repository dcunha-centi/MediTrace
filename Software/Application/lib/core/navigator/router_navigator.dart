import 'package:flutter/material.dart';
import 'package:meditrace/core/navigator/application_routes.dart';
import 'package:meditrace/features/dashboard/presentation/user_interfaces/dashboard_ui.dart';
import 'package:meditrace/features/splash/presentation/user_interfaces/splash_ui.dart';

class RouterNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static final RouteObserver<ModalRoute> routeObserver =
      RouteObserver<ModalRoute>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case  ApplicationRoutes.dashboardScreen:
      return MaterialPageRoute(builder: (_) => const DashboardScreen());
      default:
      return MaterialPageRoute(builder: (_)=> const SplashScreen());
    }
  }
}
