class Station {
  final String id;
  final int dist;
  final double latitude;
  final double longitude;
  final String name;

  Station({this.id, this.dist, this.name, this.latitude, this.longitude});

  factory Station.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data =
        json["stopLocationOrCoordLocation"][0]["StopLocation"];
    return Station(
      id: data['id'],
      dist: data['dist'],
      name: data['name'],
      latitude: data['lat'],
      longitude: data['lon'],
    );
  }
}
