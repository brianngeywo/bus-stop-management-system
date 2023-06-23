class DriverModel {
  String name;
  String id;
  String saccoId;

  DriverModel({
    required this.id,
    required this.name,
    required this.saccoId,
  });

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
      id: map["id"],
      name: map["name"],
      saccoId: map["saccoId"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "saccoId": saccoId,
    };
  }
}
