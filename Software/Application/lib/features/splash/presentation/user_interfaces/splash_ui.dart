import 'package:flutter/material.dart';
import 'package:generic_project/core/navigator/application_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration (seconds: 1),() {
      Navigator.of(context).pushReplacementNamed(ApplicationRoutes.dashboardScreen);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Splash"),
    ));
  }
}
