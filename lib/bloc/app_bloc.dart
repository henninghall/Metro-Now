import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:metro_now/bloc/app_state.dart';
import 'package:metro_now/models/Station.dart';
import 'package:metro_now/streams/closes_station_stream.dart';

enum Events { Update }

class AppBloc extends Bloc<Events, AppState> {
  Station _station;
  Position _position;
  double _northDirection;

  StreamSubscription<double> _compassSubscription;
  StreamSubscription<Position> _positionSubscription;
  StreamSubscription<Station> _stationSubscription;

  @override
  AppState get initialState =>
      AppState(stationName: "", angle: 0, distance: 0, loading: true);

  AppBloc() {
    _stationSubscription = closestStationStream.listen(onData);
    _positionSubscription = getPositionStream().listen(onPosition);
    _compassSubscription = FlutterCompass.events.listen(onCompassChange);
  }

  @override
  Stream<AppState> mapEventToState(Events event) async* {
    if (_station == null || _position == null) {
      yield AppState(
        loading: true,
      );
      return;
    }

    if (_northDirection == null) {
      yield AppState(loading: false, error: Error.noCompass);
      return;
    }

    yield AppState(
      distance: _station.distance,
      stationName: _station.name,
      angle: getAngle(),
      loading: false,
    );
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

  double getBearing() {
    return GeolocatorPlatform.bearingBetween(_position.latitude,
        _position.longitude, _station.latitude, _station.longitude);
  }

  double getAngle() {
    double bearingToStation = getBearing();
    return toRad(bearingToStation - _northDirection);
  }

  double toRad(double degrees) {
    return degrees * pi / 180;
  }

  @override
  Future<void> close() {
    _compassSubscription.cancel();
    _positionSubscription.cancel();
    _stationSubscription.cancel();
    return super.close();
  }
}
