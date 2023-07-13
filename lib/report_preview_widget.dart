import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:flutter/material.dart';

import 'models/bus_station.dart';
import 'models/driver_model.dart';

class BusesPreviewWidget extends StatelessWidget {
  final List<BusModel> busList;

  const BusesPreviewWidget({Key? key, required this.busList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: busList.length,
        itemBuilder: (context, index) {
          BusModel bus = busList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text("Bus ${bus.numberPlate} details"),
                Divider(),
                const SizedBox(height: 10),
                Text("busId:  ${bus.busId}"),
                const SizedBox(height: 5),
                Text("routeId:  ${bus.routeId}"),
                const SizedBox(height: 5),
                Text("saccoId:  ${bus.saccoId}"),
                const SizedBox(height: 5),
                Text("driverId: ${bus.driverId}"),
              ],
              // Add other fields as needed
            ),
          );
        },
      ),
    );
  }
}

class BusStationPreviewWidget extends StatelessWidget {
  final List<BusStationModel> busStationsList;

  const BusStationPreviewWidget({Key? key, required this.busStationsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: busStationsList.length,
        itemBuilder: (context, index) {
          BusStationModel busStation = busStationsList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text("Bus ${busStation.name} details"),
                Divider(),
                const SizedBox(height: 10),
                Text("bus station Id:  ${busStation.stationId}"),
                const SizedBox(height: 5),
                Text("bus station location:  ${busStation.location}"),
                const SizedBox(height: 5),
              ],
              // Add other fields as needed
            ),
          );
        },
      ),
    );
  }
}

class BusDriversPreviewWidget extends StatelessWidget {
  final List<DriverModel> driversList;

  const BusDriversPreviewWidget({Key? key, required this.driversList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: driversList.length,
        itemBuilder: (context, index) {
          DriverModel driver = driversList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //
                const SizedBox(height: 5),
                Text("Bus Driver ${driver.name} details"),
                Divider(),
                const SizedBox(height: 10),
                Text("Bus Driver Id:  ${driver.driverId}"),
                const SizedBox(height: 5),
                Text("Bus Driver contact info:  ${driver.contactInfo}"),
                const SizedBox(height: 5),
                Text("Bus Driver sacco ID:  ${driver.saccoId}"),
                const SizedBox(height: 5),
              ],
              // Add other fields as needed
            ),
          );
        },
      ),
    );
  }
}

class BusRoutesPreviewWidget extends StatelessWidget {
  final List<BusRouteModel> busRoutesList;

  const BusRoutesPreviewWidget({Key? key, required this.busRoutesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: busRoutesList.length,
        itemBuilder: (context, index) {
          BusRouteModel busRoute = busRoutesList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                    "Bus ${busRoute.source} - ${busRoute.destination} details"),
                Divider(),
                const SizedBox(height: 10),
                Text("bus route id:  ${busRoute.routeId}"),
                const SizedBox(height: 5),
                Text("bus route source:  ${busRoute.source}"),
                const SizedBox(height: 5),
                Text("bus route destination:  ${busRoute.destination}"),
                const SizedBox(height: 5),
                Text("bus route fare rate:  Kshs ${busRoute.fareRate}"),
              ],
              // Add other fields as needed
            ),
          );
        },
      ),
    );
  }
}
