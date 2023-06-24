class DriverModel {
  String driverId;
  String name;
  String contactInfo;
  String saccoId; // Store sacco ID instead of object

  DriverModel({
    required this.driverId,
    required this.name,
    required this.contactInfo,
    required this.saccoId,
  });

  Map<String, dynamic> toMap() {
    return {
      'driverId': driverId,
      'name': name,
      'contactInfo': contactInfo,
      'saccoId': saccoId,
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      driverId: map['driverId'],
      name: map['name'],
      contactInfo: map['contactInfo'],
      saccoId: map['saccoId'],
    );
  }
}
