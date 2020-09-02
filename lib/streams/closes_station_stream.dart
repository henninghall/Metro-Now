import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:metro_now/models/LatLng.dart';
import 'package:metro_now/models/Station.dart';

import '../get_closest_station.dart';

Stream<Station> _createClosestStationStream() {
  var controller = StreamController<Station>();
  Position position;
  Position lastPosition;
  Station station;

  getPositionStream().listen((currentPosition) {
    position = currentPosition;
  });

  Timer.periodic(new Duration(seconds: 10), (timer) async {
    if (position == null) return;
    if (position == lastPosition) return;
    try {
      station = getClosestStation(
          LatLng(latitude: position.latitude, longitude: position.longitude));
      controller.add(station);
      lastPosition = position;
    } catch (e) {
      controller.addError(e);
    }
  });

  return controller.stream;
}

var closestStationStream = _createClosestStationStream();
