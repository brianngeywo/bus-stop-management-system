class BusStationModel {
  int stationId;
  String name;
  String location;
  int capacity;

  BusStationModel({
    required this.stationId,
    required this.name,
    required this.location,
    required this.capacity,
  });

  Map<String, dynamic> toMap() {
    return {
      'stationId': stationId,
      'name': name,
      'location': location,
      'capacity': capacity,
    };
  }

  factory BusStationModel.fromMap(Map<String, dynamic> map) {
    return BusStationModel(
      stationId: map['stationId'],
      name: map['name'],
      location: map['location'],
      capacity: map['capacity'],
    );
  }
}
