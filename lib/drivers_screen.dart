import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/test_datas.dart';
import 'package:flutter/material.dart';

class DriversScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drivers'),
      ),
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          final driver = drivers[index];
          return ListTile(
            title: Text(driver.name),
            subtitle: Text(driver.contactInfo),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DriverDetailsScreen(driver: driver)));
            },
          );
        },
      ),
    );
  }
}
