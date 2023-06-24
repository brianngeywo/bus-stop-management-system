class SaccoModel {
  String saccoId;
  String name;
  String location;
  String phoneNumber;
  String emailAdress;
  String openingTime;
  String closingTime;
  List<String> activeDays;

  SaccoModel({
    required this.saccoId,
    required this.name,
    required this.location,
    required this.phoneNumber,
    required this.emailAdress,
    required this.openingTime,
    required this.closingTime,
    required this.activeDays,
  });

  Map<String, dynamic> toMap() {
    return {
      'saccoId': saccoId,
      'name': name,
      'location': location,
      'phoneNumber': phoneNumber,
      'emailAdress': emailAdress,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'activeDays': activeDays,
    };
  }

  factory SaccoModel.fromMap(Map<String, dynamic> map) {
    return SaccoModel(
      saccoId: map['saccoId'],
      name: map['name'],
      location: map['location'],
      phoneNumber: map['phoneNumber'],
      emailAdress: map['emailAdress'],
      openingTime: map['openingTime'],
      closingTime: map['closingTime'],
      activeDays: List<String>.from(map['activeDays']),
    );
  }
}
