import 'package:bus_sacco/dashboard_item_tile.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'main_app_bar.dart';

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
      for (var document in snapshot.docs) {
        setState(() {
          drivers.add(DriverModel.fromMap(document.data()));
        });
      }
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
      appBar: mainAppBar('Drivers List'),
      body: Row(
        children: [
          MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<List<DriverModel>>(
                stream: _driversStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error occurred'),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return DashboardTile(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriverDetailsScreen(
                                  driver: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          title: snapshot.data![index].name,
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
            ),
          ),
        ],
      ),
    );
  }
}
