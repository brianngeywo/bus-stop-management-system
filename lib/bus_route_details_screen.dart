import 'dart:html';

import 'package:bus_sacco/constants.dart';
import 'package:bus_sacco/main_app_bar.dart';
import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/sidebar.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';

import 'bus_details_screen.dart';

class BusRouteDetailsScreen extends StatefulWidget {
  final BusRouteModel route;

  BusRouteDetailsScreen({required this.route});

  @override
  State<BusRouteDetailsScreen> createState() => _BusRouteDetailsScreenState();
}

class _BusRouteDetailsScreenState extends State<BusRouteDetailsScreen> {
  List<BusModel> buses = [];
  List<DriverModel> drivers = [];
  Future<void> _generateReport() async {
    List<List<dynamic>> csvData = [];

    // Add header row for route details
    csvData.add(['Route Details']);
    csvData.add(['Source', widget.route.source]);
    csvData.add(['Destination', widget.route.destination]);
    csvData.add(['Stops', widget.route.stops.join(', ')]);
    csvData.add(['Fare Price', widget.route.fareRate.toString()]);
    csvData.add([]); // Add empty row for spacing

    // Add header row for buses
    csvData.add(['Buses in the Route']);
    csvData.add(['Number Plate', 'Status']);
    csvData.add([]); // Add empty row for spacing

    // Add data rows for buses
    for (var bus in buses) {
      csvData.add([
        bus.numberPlate,
        bus.hasArrivedDestination ? 'Arrived' : 'On the way'
      ]);
    }
    csvData.add([]); // Add empty row for spacing

    // Add header row for drivers
    csvData.add(['Drivers in the Route']);
    csvData.add(['Driver Name', 'Contact Info']);
    csvData.add([]); // Add empty row for spacing

    // Add data rows for drivers
    for (var driver in drivers) {
      csvData.add([driver.name, driver.contactInfo]);
    }

    String csvString = const ListToCsvConverter().convert(csvData);

    final encodedUri = Uri.dataFromString(csvString).toString();
    AnchorElement(
      href: encodedUri,
    )
      ..setAttribute('download', 'route_details_report.csv')
      ..click();
  }

  void getBusRouteDetails() async {
    buses = await getBusesByRouteId(widget.route.routeId);
    drivers = await getDriversByRouteId(widget.route.routeId);
  }

  @override
  void initState() {
    getBusRouteDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          mainAppBar(widget.route.source + ' - ' + widget.route.destination),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateReport,
        child: const Icon(Icons.download),
      ),
      body: Row(
        children: [
          const MySidebar(),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28.0, vertical: 16),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      '${widget.route.source} - ${widget.route.destination} Route Details',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildRouteDetail('Source', widget.route.source),
                    _buildRouteDetail('Destination', widget.route.destination),
                    _buildRouteDetail('Stops', widget.route.stops.join(', ')),
                    _buildRouteDetail(
                        'Fare Price', widget.route.fareRate.toString()),
                    const SizedBox(height: 16),
                    _buildSectionHeader('Buses in the route'),
                    _buildBusList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBusList() {
    return StreamBuilder<List<BusModel>>(
      stream: getBusesByRouteIdStream(widget.route.routeId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final busesList = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: busesList.length,
            itemBuilder: (context, index) {
              final bus = busesList[index];
              return ListTile(
                  title: Text(bus.numberPlate),
                  subtitle: Text(
                    bus.hasArrivedDestination ? 'Arrived' : 'On the way',
                    style: TextStyle(
                      color: bus.hasArrivedDestination
                          ? Colors.green
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BusDetailsScreen(bus: bus),
                      ),
                    );
                  });
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // Helper functions to retrieve related buses and drivers
  Future<List<BusModel>> getBusesByRouteId(String routeId) async {
    final buses = <BusModel>[];
    final querySnapshot =
        await busesCollection.where('routeId', isEqualTo: routeId).get();
    for (final document in querySnapshot.docs) {
      final bus = BusModel.fromMap(document.data());
      buses.add(bus);
    }
    return buses;
  }

  Stream<List<BusModel>> getBusesByRouteIdStream(String routeId) {
    return busesCollection.where('routeId', isEqualTo: routeId).snapshots().map(
        (event) => event.docs.map((e) => BusModel.fromMap(e.data())).toList());
  }

  Future<List<DriverModel>> getDriversByRouteId(String routeId) async {
    final drivers = <DriverModel>[];
    final querySnapshot =
        await driversCollection.where('routeId', isEqualTo: routeId).get();
    for (final document in querySnapshot.docs) {
      final driver = DriverModel.fromMap(document.data());
      drivers.add(driver);
    }
    return drivers;
  }
}
