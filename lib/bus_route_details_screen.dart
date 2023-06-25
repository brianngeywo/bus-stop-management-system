import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:flutter/material.dart';

class BusRouteDetailsScreen extends StatefulWidget {
  final BusRouteModel route;

  BusRouteDetailsScreen({required this.route});

  @override
  State<BusRouteDetailsScreen> createState() => _BusRouteDetailsScreenState();
}

class _BusRouteDetailsScreenState extends State<BusRouteDetailsScreen> {
  List<BusModel> buses = [];
  List<DriverModel> drivers = [];
  void getBusRouteDetails() async {
    buses = await getBusesByRouteId(widget.route.routeId);
    drivers = await getDriversByRouteId(widget.route.routeId);
  }

  @override
  void initState() {
    // TODO: implement initState
    getBusRouteDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Route ID: ${widget.route.routeId}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Source: ${widget.route.source}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Destination: ${widget.route.destination}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Stops: ${widget.route.stops.join(', ')}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Fare Rate: ${widget.route.fareRate}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Buses:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<BusModel>>(
                stream: getBusesByRouteIdStream(widget.route.routeId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].numberPlate),
                            subtitle: Text(snapshot.data![index].busId),
                            trailing:
                                snapshot.data![index].hasArrivedDestination
                                    ? const Text('Arrived')
                                    : const Text('On the way'),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  // Helper functions to retrieve related buses and drivers
  Future<List<BusModel>> getBusesByRouteId(String routeId) async {
    List<BusModel> buses = [];
    await busesCollection
        .where('routeId', isEqualTo: routeId)
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element.data());
              var bus = BusModel.fromMap(element.data());
              buses.add(bus);
            }));
    return buses;
  }

  Stream<List<BusModel>> getBusesByRouteIdStream(String routeId) {
    return busesCollection.where('routeId', isEqualTo: routeId).snapshots().map(
        (event) => event.docs.map((e) => BusModel.fromMap(e.data())).toList());
  }

  Future<List<DriverModel>> getDriversByRouteId(String routeId) async {
    List<DriverModel> drivers = [];
    await driversCollection
        .where('routeId', isEqualTo: routeId)
        .get()
        .then((value) => value.docs.forEach((element) {
              var driver = DriverModel.fromMap(element.data());
              drivers.add(driver);
            }));
    return drivers;
  }
}
