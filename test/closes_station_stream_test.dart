import 'package:flutter_test/flutter_test.dart';
import 'package:metro_now/get_closest_station.dart';

import 'package:metro_now/models/LatLng.dart';

void main() {
  test('Close to Hammarbyhöjden', () async {
    var coordinate = LatLng(latitude: 59.2917305, longitude: 18.1009683);
    var closest = getClosestStation(coordinate);
    expect(closest.name, "Hammarbyhöjden");
  });

  test(
      'Between Hammarbyhöjden and Skärmarbrink - slightly closer to skärmbrink',
      () async {
    var coordinate = LatLng(latitude: 59.2938191, longitude: 18.0936185);
    var closest = getClosestStation(coordinate);
    expect(closest.name, "Skärmarbrink");
  });
}
