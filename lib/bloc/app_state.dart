import 'package:equatable/equatable.dart';

enum Error { noCompass }

class AppState extends Equatable {
  final String stationName;
  final double angle;
  final double distance;
  final bool loading;
  final Error error;

  AppState(
      {this.stationName, this.angle, this.distance, this.loading, this.error});

  @override
  List<Object> get props =>
      [this.stationName, this.angle, this.distance, this.loading, this.error];
}
