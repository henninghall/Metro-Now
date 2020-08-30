import 'package:metro_now/models/Station.dart';
import 'package:metro_now/utils.dart';

import 'data/stations.dart';
import 'models/LatLng.dart';

Station getClosestStation(LatLng coordinate) {
  Station closestStation;
  allEntrances.forEach((station) {
    var distance = calculateDistance(coordinate.latitude, coordinate.longitude,
        station.latitude, station.longitude);
    var isFirstStation = closestStation == null;
    bool isCloserThanCurrentClosest() {
      return distance < closestStation.distance;
    }

    if (isFirstStation || isCloserThanCurrentClosest()) {
      closestStation = Station.fromStationWithoutDistance(station, distance);
    }
  });
  return closestStation;
}
