import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_now/bloc/app_state.dart';
import 'package:metro_now/models/Station.dart';
import 'package:metro_now/streams/closes_station_stream.dart';
import 'package:metro_now/streams/position_stream.dart';

enum Events { Update }

class AppBloc extends Bloc<Events, AppState> {
  Station _station;
  Position _position;
  double _northDirection;

  StreamSubscription<double> _compassSubscription;
  StreamSubscription<Position> _positionSubscription;
  StreamSubscription<Station> _stationSubscription;

  @override
  AppState get initialState => AppState(stationName: "", angle: 0, distance: 0);

  AppBloc() {
    _stationSubscription = closestStationStream.listen(onData);
    _positionSubscription = getPositionStream().listen(onPosition);
    _compassSubscription = FlutterCompass.events.listen(onCompassChange);
  }

  @override
  Stream<AppState> mapEventToState(Events event) async* {
    if (_station == null || _position == null || _northDirection == null)
      return;
    yield AppState(
        distance: _station.distance,
        stationName: _station.name,
        angle: await getAngle());
  }

  void onData(Station station) {
    _station = station;
    add(Events.Update);
  }

  void onPosition(Position position) {
    _position = position;
    add(Events.Update);
  }

  void onCompassChange(double direction) {
    _northDirection = direction;
    add(Events.Update);
  }

  Future<double> getBearing() async {
    return await Geolocator().bearingBetween(_position.latitude,
        _position.longitude, _station.latitude, _station.longitude);
  }

  Future<double> getAngle() async {
    double bearingToStation = await getBearing();
    return (_northDirection + bearingToStation) * pi/180 * -1;
  }

  @override
  Future<void> close() {
    _compassSubscription.cancel();
    _positionSubscription.cancel();
    _stationSubscription.cancel();
    return super.close();
  }
}
