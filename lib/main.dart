import 'package:bus_sacco/app_theme.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/dashboard_screen.dart';
import 'package:bus_sacco/firebase_options.dart';
import 'package:bus_sacco/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//initialize firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //add firebase options to flutter main

  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: AppTheme.lightTheme,
      home: auth.currentUser != null ? DashboardScreen() : LoginPage(),
    );
  }
}
