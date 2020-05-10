import 'package:metro_now/data/rawStationData.dart';
import 'package:metro_now/models/StationWithoutDistance.dart';

List<StationWithoutDistance> stations = rawStationData
    .map((rawData) => StationWithoutDistance(
        name: rawData[0], latitude: rawData[1][0], longitude: rawData[1][1]))
    .toList();
