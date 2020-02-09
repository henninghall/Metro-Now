import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_now/models/Station.dart';
import 'package:metro_now/images/arrow_image.dart';
import 'package:metro_now/streams/closes_station_stream.dart';
import 'package:metro_now/streams/position_stream.dart';

import '../utils.dart';
import 'distance_text.dart';
import 'station_text.dart';

class Content extends StatefulWidget {
  Content({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Content> {
  Station _station;
  Position _position;
  double _northDirection;
  double _bearingToStation;

  @override
  void initState() {
    super.initState();
    listenForClosesStation();
    listenForPosition();
    listenForCompass();
  }

  @override
  Widget build(BuildContext context) {
    if (_position == null || _station == null)
      return Center(child: CircularProgressIndicator());
    if (_bearingToStation == null) return Center(child: Text("Bearing error"));
    if (_northDirection == null) return Center(child: Text("Copmass error"));

    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StationText(
            stationName: _station.name,
          ),
          Container(
            alignment: Alignment.center,
            child: new Transform.rotate(
              angle: getAngle(),
              child: arrowImage,
            ),
          ),
          DistanceText(
            distance: getDistance(),
          ),
        ]);
  }

  getAngle() {
    return (_northDirection - _bearingToStation ?? 0) * (pi / 180) * -1;
  }

  listenForClosesStation() {
    closestStationStream.listen((currentlyClosestStation) {
      setState(() {
        _station = currentlyClosestStation;
      });
      updateBearing();
    });
  }

  listenForPosition() {
    getPositionStream().listen((Position position) {
      setState(() {
        _position = position;
      });
      updateBearing();
    });
  }

  listenForCompass() {
    FlutterCompass.events.listen((double direction) {
      setState(() {
        _northDirection = direction;
      });
    });
  }

  int getDistance() {
    return calculateDistance(_station.latitude, _station.longitude,
            _position.latitude, _position.longitude)
        .round();
  }

  void updateBearing() {
    if (_position == null || _station == null) return;
    Geolocator()
        .bearingBetween(_position.latitude, _position.longitude,
            _station.latitude, _station.longitude)
        .then((bearing) {
      _bearingToStation = bearing;
    });
  }
}
