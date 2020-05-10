import 'StationWithoutDistance.dart';

class Station extends StationWithoutDistance {
  double distance;

  Station({name, latitude, longitude, this.distance})
      : super(name: name, latitude: latitude, longitude: longitude);

  factory Station.fromStationWithoutDistance(
      StationWithoutDistance station, double distance) {
    return Station(
        longitude: station.longitude,
        latitude: station.latitude,
        name: station.name,
        distance: distance);
  }
}
