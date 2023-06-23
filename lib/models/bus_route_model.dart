class BusRouteModel {
  String id;
  String startPoint;
  String endPoint;

  BusRouteModel({
    required this.id,
    required this.startPoint,
    required this.endPoint,
  });

  factory BusRouteModel.fromMap(Map<String, dynamic> map) {
    return BusRouteModel(
      id: map["id"],
      startPoint: map["startPoint"],
      endPoint: map["endPoint"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "startPoint": startPoint,
      "endPoint": endPoint,
    };
  }
}
