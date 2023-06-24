import 'dart:math';

import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';
import 'package:uuid/uuid.dart';

List<SaccoModel> saccos = [
  SaccoModel(
    saccoId: Uuid().v4(),
    name: 'Sacco 1',
    emailAdress: 'sacco1@email.com',
    phoneNumber: '123456789',
    openingTime: '8 Am',
    location: 'Denver',
    closingTime: '9 Pm',
    activeDays: [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ],
  ),
  SaccoModel(
    saccoId: Uuid().v4(),
    name: 'Sacco 2',
    emailAdress: 'sacco2@email.com',
    phoneNumber: '987654321',
    openingTime: '8 Am',
    location: 'New York',
    closingTime: '9 Pm',
    activeDays: [
      'Monday',
      'Tuesday',
      'Thursday',
      'Friday',
    ],
  ),
];

List<DriverModel> drivers = [
  DriverModel(
    driverId: Uuid().v4(),
    name: 'John Doe',
    contactInfo: 'john@example.com',
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
  ),
  DriverModel(
    driverId: Uuid().v4(),
    name: 'Jane Smith',
    contactInfo: 'jane@example.com',
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
  ),
  DriverModel(
    driverId: Uuid().v4(),
    name: 'Michael Johnson',
    contactInfo: 'michael@example.com',
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
  ),
  DriverModel(
    driverId: Uuid().v4(),
    name: 'Emily Brown',
    contactInfo: 'emily@example.com',
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
  ),
];

List<BusModel> buses = [
  BusModel(
    busId: Uuid().v4(),
    numberPlate: 'ABC123',
    routeId: busRoutes[Random().nextInt(busRoutes.length)].routeId,
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
    driverId: drivers[Random().nextInt(drivers.length)].driverId,
    hasLeftSource: false,
    hasArrivedDestination: false,
  ),
  BusModel(
    busId: Uuid().v4(),
    numberPlate: 'XYZ789',
    routeId: busRoutes[Random().nextInt(busRoutes.length)].routeId,
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
    driverId: drivers[Random().nextInt(drivers.length)].driverId,
    hasLeftSource: true,
    hasArrivedDestination: false,
  ),
  BusModel(
    busId: Uuid().v4(),
    numberPlate: 'DEF456',
    routeId: busRoutes[Random().nextInt(busRoutes.length)].routeId,
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
    driverId: drivers[Random().nextInt(drivers.length)].driverId,
    hasLeftSource: true,
    hasArrivedDestination: true,
  ),
  BusModel(
    busId: Uuid().v4(),
    numberPlate: 'PQR321',
    routeId: busRoutes[Random().nextInt(busRoutes.length)].routeId,
    saccoId: saccos[Random().nextInt(saccos.length)].saccoId,
    driverId: drivers[Random().nextInt(drivers.length)].driverId,
    hasLeftSource: false,
    hasArrivedDestination: true,
  ),
];

List<BusRouteModel> busRoutes = [
  BusRouteModel(
    routeId: Uuid().v4(),
    source: 'New York',
    destination: 'Los Angeles',
    stops: ['Chicago', 'Denver', 'Las Vegas'],
    fareRate: 50.0,
  ),
  BusRouteModel(
    routeId: Uuid().v4(),
    source: 'California',
    destination: 'Toronto',
    stops: ['Las Vegas', 'Salt Lake City', 'Seattle'],
    fareRate: 40.0,
  ),
];
