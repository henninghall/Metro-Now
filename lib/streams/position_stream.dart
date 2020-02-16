import 'package:geolocator/geolocator.dart';

Stream<Position> getPositionStream() {
  return Geolocator()
      .getPositionStream(LocationOptions(accuracy: LocationAccuracy.high))
      .where((position) => position != null);
}
