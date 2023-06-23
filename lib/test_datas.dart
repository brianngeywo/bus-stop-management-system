import 'package:bus_sacco/models/bus_model.dart';
import 'package:bus_sacco/models/bus_route_model.dart';
import 'package:bus_sacco/models/bus_station.dart';
import 'package:bus_sacco/models/driver_model.dart';
import 'package:bus_sacco/models/sacco_model.dart';

List<SaccoModel> saccos = [
  SaccoModel(
    saccoId: 1,
    name: 'Sacco 1',
    busStationIds: [1, 2, 3, 9, 10],
    contactInfo: 'sacco1@email.com',
  ),
  SaccoModel(
    saccoId: 2,
    name: 'Sacco 2',
    busStationIds: [4, 5, 6, 7, 8],
    contactInfo: 'sacco2@email.com',
  ),
];

List<BusStationModel> busStations = [
  BusStationModel(
    stationId: 1,
    name: 'Denver Station',
    location: 'Denver',
    capacity: 50,
  ),
  BusStationModel(
    stationId: 2,
    name: 'New York Station',
    location: 'New York',
    capacity: 40,
  ),
  BusStationModel(
    stationId: 3,
    name: 'Chicago Station',
    location: 'Chicago',
    capacity: 30,
  ),
  BusStationModel(
    stationId: 4,
    name: 'San Francisco Station',
    location: 'San Francisco',
    capacity: 35,
  ),
  BusStationModel(
    stationId: 5,
    name: 'Seattle Station',
    location: 'Seattle',
    capacity: 45,
  ),
  BusStationModel(
    stationId: 6,
    name: 'Boston Station',
    location: 'Boston',
    capacity: 25,
  ),
  BusStationModel(
    stationId: 7,
    name: 'Miami Station',
    location: 'Miami',
    capacity: 30,
  ),
  BusStationModel(
    stationId: 8,
    name: 'Houston Station',
    location: 'Houston',
    capacity: 35,
  ),
  BusStationModel(
    stationId: 9,
    name: 'Phoenix Station',
    location: 'Phoenix',
    capacity: 40,
  ),
  BusStationModel(
    stationId: 10,
    name: 'Atlanta Station',
    location: 'Atlanta',
    capacity: 45,
  ),
];

List<DriverModel> drivers = [
  DriverModel(
    driverId: 1,
    name: 'John Doe',
    contactInfo: 'john@example.com',
    saccoId: 1,
  ),
  DriverModel(
    driverId: 2,
    name: 'Jane Smith',
    contactInfo: 'jane@example.com',
    saccoId: 2,
  ),
  DriverModel(
    driverId: 3,
    name: 'Michael Johnson',
    contactInfo: 'michael@example.com',
    saccoId: 1,
  ),
  DriverModel(
    driverId: 4,
    name: 'Emily Brown',
    contactInfo: 'emily@example.com',
    saccoId: 2,
  ),
];

List<BusModel> buses = [
  BusModel(
    busId: 1,
    numberPlate: 'ABC123',
    routeId: 1,
    saccoId: 1,
    driverId: 1,
    hasLeftSource: false,
    hasArrivedDestination: false,
  ),
  BusModel(
    busId: 2,
    numberPlate: 'XYZ789',
    routeId: 2,
    saccoId: 2,
    driverId: 2,
    hasLeftSource: true,
    hasArrivedDestination: false,
  ),
  BusModel(
    busId: 3,
    numberPlate: 'DEF456',
    routeId: 1,
    saccoId: 1,
    driverId: 3,
    hasLeftSource: true,
    hasArrivedDestination: true,
  ),
  BusModel(
    busId: 4,
    numberPlate: 'PQR321',
    routeId: 2,
    saccoId: 2,
    driverId: 4,
    hasLeftSource: false,
    hasArrivedDestination: true,
  ),
];

List<BusRouteModel> busRoutes = [
  BusRouteModel(
    routeId: 1,
    source: 'New York',
    destination: 'Los Angeles',
    stops: ['Chicago', 'Denver', 'Las Vegas'],
    fareRate: 50.0,
  ),
  BusRouteModel(
    routeId: 2,
    source: 'California',
    destination: 'Toronto',
    stops: ['Las Vegas', 'Salt Lake City', 'Seattle'],
    fareRate: 40.0,
  ),
];
