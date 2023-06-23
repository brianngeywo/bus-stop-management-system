import 'package:bus_sacco/bus_routes_screen.dart';
import 'package:bus_sacco/buses_screen.dart';
import 'package:bus_sacco/saccos_screen.dart';
import 'package:flutter/material.dart';

import 'drivers_screen.dart';

void main() {
  runApp(DashboardApp());
}

class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          DashboardTile(
            title: 'Drivers',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriversScreen()),
              );
            },
          ),
          DashboardTile(
            title: 'Saccos',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SaccosScreen()),
              );
            },
          ),
          DashboardTile(
            title: 'Buses',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusesScreen()),
              );
            },
          ),
          DashboardTile(
            title: 'Bus Routes',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BusRoutesScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  DashboardTile({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}
