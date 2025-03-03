import 'package:f_patrol/views/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FPatrolApp());
}

class FPatrolApp extends StatelessWidget {
  const FPatrolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, title: 'Flutter UI Test', theme: ThemeData(primarySwatch: Colors.blue), home: const SplashScreen());
  }
}
