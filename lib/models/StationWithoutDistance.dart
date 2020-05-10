import 'LatLng.dart';

class StationWithoutDistance extends LatLng {
  final String name;

  StationWithoutDistance({this.name, latitude, longitude})
      : super(latitude: latitude, longitude: longitude);
}
