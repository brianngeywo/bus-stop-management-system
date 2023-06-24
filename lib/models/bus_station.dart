class BusStationModel {
  String stationId;
  String name;
  String location;
  List<String> saccoIds;

  BusStationModel({
    required this.stationId,
    required this.name,
    required this.location,
    required this.saccoIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'stationId': stationId,
      'name': name,
      'location': location,
      'saccoIds': saccoIds,
    };
  }

  factory BusStationModel.fromMap(Map<String, dynamic> map) {
    return BusStationModel(
      stationId: map['stationId'],
      name: map['name'],
      location: map['location'],
      saccoIds: List<String>.from(map['saccoIds']),
    );
  }
}
