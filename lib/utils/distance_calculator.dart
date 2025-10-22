import 'dart:math';
class DistanceCalculator {
  static double distanceBetween(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371000;
    final dLat = _rad(lat2 - lat1);
    final dLon = _rad(lon2 - lon1);
    final a = sin(dLat/2)*sin(dLat/2) + cos(_rad(lat1))*cos(_rad(lat2))*sin(dLon/2)*sin(dLon/2);
    final c = 2 * atan2(sqrt(a), sqrt(1-a));
    return R * c;
  }
  static double _rad(double v) => v * pi / 180;
}
