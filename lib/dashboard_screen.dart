import 'package:bus_sacco/bus_routes_screen.dart';
import 'package:bus_sacco/bus_stations_view_screen.dart';
import 'package:bus_sacco/buses_screen.dart';
import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/drivers_screen.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/saccos_screen.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar('TranspoLink Sacco Dashboard'),
      body: Row(
        children: [
          MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey[200],
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  DashboardTile(
                    title: "Bus Stations",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusStationsViewScreen(),
                        ),
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
                    title: 'Drivers',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DriversScreen()),
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
                        MaterialPageRoute(
                            builder: (context) => BusRoutesScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
