import 'dart:math';

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
