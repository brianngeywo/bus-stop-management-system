import 'package:bus_sacco/bus_route_details_screen.dart';
import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/driver_details_screen.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:bus_sacco/sacco_details_screen.dart';
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
      appBar: AppBar(
        title: const Text('Bus Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Bus ID: ${widget.bus.busId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Number Plate: ${widget.bus.numberPlate}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
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
                child: route != null
                    ? Text(
                        'Route: ${route?.source} - ${route?.destination}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    : const Text(
                        'Route: Loading...',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
          ),
          sacco != null
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
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
                    child: Text(
                      'Sacco: ${sacco!.name}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : const Text(
                  'Sacco: Loading...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                // Navigate to DriverDetailsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverDetailsScreen(driver: driver!),
                  ),
                );
              },
              child: Text(
                'Driver: ${driver!.name}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Has Left Source: ${widget.bus.hasLeftSource}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Has Arrived at Destination: ${widget.bus.hasArrivedDestination}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
