import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  
  Position? _currentPosition;
  String? _currentAddress;
  bool _isLoading = false;
  String? _errorMessage;

  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get current location
  Future<void> getCurrentLocation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentPosition = await _locationService.getCurrentLocation();
      if (_currentPosition != null) {
        _currentAddress = await _locationService.getAddressFromLatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get address from coordinates
  Future<String?> getAddress(double lat, double lng) async {
    try {
      return await _locationService.getAddressFromLatLng(lat, lng);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Calculate distance between two points
  double calculateDistance(double startLat, double startLng, double endLat, double endLng) {
    return _locationService.calculateDistance(startLat, startLng, endLat, endLng);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
