import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:metro_now/models/Station.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:metro_now/streams/position_stream.dart';
import 'package:metro_now/utils.dart';

Future<Station> _fetchClosestStation(position) async {
  final response = await http.get(getApiUrl(position));
  if (response.statusCode == 200) {
    return Station.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load station');
  }
}

Stream<Station> _createClosestStationStream() {
  var controller = StreamController<Station>();
  Position position;
  Station station;

  getPositionStream().listen((currentPosition) {
    position = currentPosition;
  });

  Timer.periodic(new Duration(seconds: 10), (timer) async {
    if (position == null) return;
    try {
      station = await _fetchClosestStation(position);
      controller.add(station);
    } catch (e) {
      controller.addError(e);
    }
  });

  return controller.stream;
}

var closestStationStream = _createClosestStationStream();
