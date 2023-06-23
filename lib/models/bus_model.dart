import 'package:bus_sacco/models/bus_route_model.dart';

class BusModel {
  String id;
  String numberPlate;
  String driver;
  List<BusRouteModel> routes;

  BusModel({
    required this.routes,
    required this.id,
    required this.driver,
    required this.numberPlate,
  });

  BusModel fromMap(Map<String, dynamic> map) {
    return BusModel(
      id: map["id"],
      routes: (map["routes"] as List<dynamic>)
          .map((route) => BusRouteModel.fromMap(route))
          .toList(),
      driver: map["driver"],
      numberPlate: map["numberPlate"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "routes": routes.map((route) => route.toMap()).toList(),
      "driver": driver,
      "numberPlate": numberPlate,
    };
  }
}
