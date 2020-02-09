import 'dart:math';
import 'package:geolocator/geolocator.dart';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742000 * asin(sqrt(a));
}

double calculateBearing(double lat1, double lng1, double lat2, double lng2) {
  var dLon = (lng2 - lng1);
  var y = sin(dLon) * cos(lat2);
  var x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
  var brng = atan2(y, x) * 180 / pi;
  return 360 - ((brng + 360) % 360);
}

String getApiUrl(Position position) {
  var key = "58ed5879c9564e158f48540fe640d8a4";
  var latitude = position.latitude;
  var longitude = position.longitude;
  var maxDist = 2000; // 2000 is the maximum allowed value in the api
  return "http://api.sl.se/api2/nearbystopsv2.json?key=$key&originCoordLat=$latitude&originCoordLong=$longitude&maxNo=5&r=$maxDist&products=2";
}
