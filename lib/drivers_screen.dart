import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class DriversScreen extends StatefulWidget {
  @override
  State<DriversScreen> createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {
  List<DriverModel> drivers = [];
  // fetch drivers stream
  Stream<List<DriverModel>> _driversStream() {
    return driversCollection.snapshots().map((snapshot) {
      List<DriverModel> drivers = [];
      snapshot.docs.forEach((document) {
        drivers.add(DriverModel.fromMap(document.data()));
      });
      return drivers;
    });
  }

  // fetch drivers
  List<DriverModel> _fetchDrivers() {
    driversCollection.get().then((snapshot) {
      List<DriverModel> drivers = [];
      for (var doc in snapshot.docs) {
        final driver = DriverModel.fromMap(doc.data());
        drivers.add(driver);
      }
    });
    setState(() {
      drivers = drivers;
    });
    return drivers;
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchDrivers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drivers'),
      ),
      body: StreamBuilder<List<DriverModel>>(
        stream: _driversStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred'),
            );
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DriverDetailsScreen(
                          driver: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].contactInfo),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
