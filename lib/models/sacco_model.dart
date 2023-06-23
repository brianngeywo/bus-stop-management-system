class SaccoModel {
  int saccoId;
  String name;
  String contactInfo;
  List<int> busStationIds; // Store bus station IDs instead of objects

  SaccoModel({
    required this.saccoId,
    required this.name,
    required this.contactInfo,
    required this.busStationIds,
  });

  Map<String, dynamic> toMap() {
    return {
      'saccoId': saccoId,
      'name': name,
      'contactInfo': contactInfo,
      'busStationIds': busStationIds,
    };
  }

  factory SaccoModel.fromMap(Map<String, dynamic> map) {
    return SaccoModel(
      saccoId: map['saccoId'],
      name: map['name'],
      contactInfo: map['contactInfo'],
      busStationIds: List<int>.from(map['busStationIds']),
    );
  }
}
