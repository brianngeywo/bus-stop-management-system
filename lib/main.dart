import 'package:bus_sacco/app_theme.dart';
import 'package:bus_sacco/bus_registration_screen.dart';
import 'package:bus_sacco/bus_route_registration_screen.dart';
import 'package:bus_sacco/bus_routes_screen.dart';
import 'package:bus_sacco/bus_station_registration_screen.dart';
import 'package:bus_sacco/bus_stations_view_screen.dart';
import 'package:bus_sacco/buses_screen.dart';
import 'package:bus_sacco/driver_registration_screen.dart';
import 'package:bus_sacco/firebase_options.dart';
import 'package:bus_sacco/sacco_registration_screen.dart';
import 'package:bus_sacco/saccos_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'drivers_screen.dart';

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
      darkTheme: AppTheme.darkTheme,
      home: DashboardScreen(),
      routes: {
        '/bus_stations': (context) => BusStationsViewScreen(),
        '/saccos': (context) => SaccosScreen(),
        '/drivers': (context) => DriversScreen(),
        '/buses': (context) => BusesScreen(),
        '/bus_routes': (context) => BusRoutesScreen(),
        '/bus_registration': (context) => BusRegistrationScreen(),
        '/sacco_registration': (context) => SaccoRegistrationScreen(),
        '/bus_station_registration': (context) =>
            BusStationRegistrationScreen(),
        '/driver_registration': (context) => DriverRegistrationScreen(),
        '/bus_route_registration': (context) => BusRouteRegistrationScreen(),
      },
    );
  }
}
