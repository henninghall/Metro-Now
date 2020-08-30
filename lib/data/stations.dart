import 'package:metro_now/data/stationData.dart';
import 'package:metro_now/data/stationEntrances.dart';
import 'package:metro_now/models/StationWithoutDistance.dart';

List<StationWithoutDistance> stations = rawStationData
    .map((rawData) => StationWithoutDistance(
        name: rawData[0], latitude: rawData[1][0], longitude: rawData[1][1]))
    .toList();

List<StationWithoutDistance> getStations() {
  List<StationWithoutDistance> output = [];
  var entrances = stationEntrances.keys;
  stations.forEach((station) {
    // use entrance coordinates when that data exists
    if (entrances.contains(station.name)) {
      stationEntrances[station.name].forEach((coorindates) {
        output.add(StationWithoutDistance(
            name: station.name,
            latitude: coorindates[0],
            longitude: coorindates[1]));
      });
    }
    // use coordinate from stationData
    else {
      output.add(station);
    }
  });
  return output;
}

List<StationWithoutDistance> allEntrances = getStations();
