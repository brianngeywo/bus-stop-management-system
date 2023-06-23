class SaccoModel {
  int saccoId;
  String name;
  String contactInfo;

  SaccoModel({
    required this.saccoId,
    required this.name,
    required this.contactInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      'saccoId': saccoId,
      'name': name,
      'contactInfo': contactInfo,
    };
  }

  factory SaccoModel.fromMap(Map<String, dynamic> map) {
    return SaccoModel(
      saccoId: map['saccoId'],
      name: map['name'],
      contactInfo: map['contactInfo'],
    );
  }
}
