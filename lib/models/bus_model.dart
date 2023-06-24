class BusModel {
  String busId;
  String numberPlate;
  String routeId; // Store route ID instead of object
  String saccoId; // Store sacco ID instead of object
  String driverId; // Store driver ID instead of object
  bool hasLeftSource;
  bool hasArrivedDestination;

  BusModel({
    required this.busId,
    required this.numberPlate,
    required this.routeId,
    required this.saccoId,
    required this.driverId,
    this.hasLeftSource = false,
    this.hasArrivedDestination = false,
  });

  void markLeftSource() {
    hasLeftSource = true;
  }

  void markArrivedDestination() {
    hasArrivedDestination = true;
  }

  Map<String, dynamic> toMap() {
    return {
      'busId': busId,
      'numberPlate': numberPlate,
      'routeId': routeId,
      'saccoId': saccoId,
      'driverId': driverId,
      'hasLeftSource': hasLeftSource,
      'hasArrivedDestination': hasArrivedDestination,
    };
  }

  factory BusModel.fromMap(Map<String, dynamic> map) {
    return BusModel(
      busId: map['busId'],
      numberPlate: map['numberPlate'],
      routeId: map['routeId'],
      saccoId: map['saccoId'],
      driverId: map['driverId'],
      hasLeftSource: map['hasLeftSource'] ?? false,
      hasArrivedDestination: map['hasArrivedDestination'] ?? false,
    );
  }
}
