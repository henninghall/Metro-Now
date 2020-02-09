import 'package:geolocator/geolocator.dart';

getPositionStream() {
  return Geolocator()
      .getPositionStream(LocationOptions(accuracy: LocationAccuracy.high))
      .where((position) => position != null);
}
