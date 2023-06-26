import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:flutter/material.dart';

class BusDetailsScreen extends StatefulWidget {
  final BusModel bus;

  BusDetailsScreen({super.key, required this.bus});

  @override
  State<BusDetailsScreen> createState() => _BusDetailsScreenState();
}

class _BusDetailsScreenState extends State<BusDetailsScreen> {
  DriverModel? driver;
  BusRouteModel? route;
  SaccoModel? sacco;
  void getAllDetails() async {
    driver = await getDriverById(widget.bus.driverId);
    route = await getRouteById(widget.bus.routeId);
    sacco = await getSaccoById(widget.bus.saccoId);
  }

  initState() {
    getAllDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the related entities

    return Scaffold(
      appBar: mainAppBar('Bus Details'),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.all(16),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Driver details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      // Navigate to DriverDetailsScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DriverDetailsScreen(driver: driver!),
                        ),
                      );
                    },
                    title: Text(
                      driver != null ? driver!.name : 'Loading...',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Number Plate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      widget.bus.numberPlate,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Bus route',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                      onTap: () {
                        // Navigate to BusRouteDetailsScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BusRouteDetailsScreen(route: route!),
                          ),
                        );
                      },
                      title: route != null
                          ? Text(
                              '${route?.source} - ${route?.destination}',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          : const Text(
                              'Loading...',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Sacco Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  sacco != null
                      ? ListTile(
                          onTap: () {
                            // Navigate to SaccoDetailsScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SaccoDetailsScreen(sacco: sacco!),
                              ),
                            );
                          },
                          title: Text(
                            'Sacco: ${sacco!.name}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            'Sacco location: ${sacco!.location}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        )
                      : const Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Bus Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    widget.bus.hasLeftSource == true
                        ? 'The bus has already left the station'
                        : 'The bus is yet to leave the station',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(
                        widget.bus.hasLeftSource == true ? 16 : 0),
                    child: Text(
                      widget.bus.hasLeftSource != true
                          ? ''
                          : widget.bus.hasArrivedDestination
                              ? "Bus has arrived"
                                  " at destination"
                              : 'Bus has not arrived at destination',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related entities
  Future<DriverModel> getDriverById(String driverId) async {
    DriverModel? driver;
    //fetch drivers from firestore
    await driversCollection.doc(driverId).get().then((value) {
      setState(() {
        driver = DriverModel.fromMap(value.data()!);
      });
    });
    return driver!;
  }

  Future<BusRouteModel?> getRouteById(String routeId) async {
    BusRouteModel? route;
    //fetch bus routes from firestore
    await busRoutesCollection.doc(routeId).get().then((value) {
      setState(() {
        route = BusRouteModel.fromMap(value.data()!);
      });
    });
    return route;
  }

  Future<SaccoModel?> getSaccoById(String saccoId) async {
    SaccoModel? saccoModel;
    await saccoCollection.doc(saccoId).get().then((value) {
      setState(() {
        saccoModel = SaccoModel.fromMap(value.data()!);
      });
      return saccoModel;
    });
    return saccoModel;
  }
}
