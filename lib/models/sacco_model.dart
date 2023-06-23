import 'package:bus_sacco/models/bus_route_model.dart';

class SaccoModel {
  String id;
  List<String> drivers;
  List<BusRouteModel> routes;
  List<String> buses;

  SaccoModel({
    required this.id,
    required this.buses,
    required this.drivers,
    required this.routes,
  });

  factory SaccoModel.fromMap(Map<String, dynamic> map) {
    return SaccoModel(
      id: map["id"],
      buses: map["buses"],
      drivers: map["drivers"],
      routes: (map["routes"] as List<dynamic>)
          .map((busRoute) => BusRouteModel.fromMap(busRoute))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "drivers": drivers,
      "buses": buses,
      "routes": routes.map((route) => route.toMap()).toList(),
    };
  }
}
