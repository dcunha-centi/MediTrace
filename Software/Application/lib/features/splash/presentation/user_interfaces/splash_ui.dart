import 'package:flutter/material.dart';
import 'package:meditrace/core/navigator/application_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).pushReplacementNamed(ApplicationRoutes.dashboardScreen);
  });
}



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
  body: Center(
    child: Text(
      "Meditrace",
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.bold, 
        color: Color.fromARGB(255, 5, 66, 116),
      ),
    ),
  ),
);

  }
}
