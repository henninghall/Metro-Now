import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  final String stationName;
  final double angle;
  final double distance;

  AppState({this.stationName, this.angle, this.distance});

  @override
  List<Object> get props => [this.stationName, this.angle, this.distance];
}
