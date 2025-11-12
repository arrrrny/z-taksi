import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math' show cos, sqrt, asin;

class LocationService {
  // Get current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied');
    }

    // Get current position
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // Get address from coordinates
  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}';
      }
      return 'Unknown location';
    } catch (e) {
      return 'Unable to get address';
    }
  }

  // Calculate distance between two points (in kilometers)
  double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
    const double earthRadius = 6371; // Radius of earth in kilometers

    double dLat = _toRadians(endLat - startLat);
    double dLng = _toRadians(endLng - startLng);

    double a = (sin(dLat / 2) * sin(dLat / 2)) +
        cos(_toRadians(startLat)) *
            cos(_toRadians(endLat)) *
            (sin(dLng / 2) * sin(dLng / 2));

    double c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * (3.141592653589793 / 180);
  }

  double sin(double x) {
    // Simple sine approximation using Taylor series
    double result = x;
    double term = x;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }
}
