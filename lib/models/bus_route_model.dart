class BusRouteModel {
  String routeId;
  String source;
  String destination;
  List<String> stops;
  double fareRate;

  BusRouteModel({
    required this.routeId,
    required this.source,
    required this.destination,
    required this.stops,
    required this.fareRate,
  });

  Map<String, dynamic> toMap() {
    return {
      'routeId': routeId,
      'source': source,
      'destination': destination,
      'stops': stops,
      'fareRate': fareRate,
    };
  }

  factory BusRouteModel.fromMap(Map<String, dynamic> map) {
    return BusRouteModel(
      routeId: map['routeId'],
      source: map['source'],
      destination: map['destination'],
      stops: List<String>.from(map['stops']),
      fareRate: map['fareRate'],
    );
  }
}
