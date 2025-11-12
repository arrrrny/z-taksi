import 'package:flutter/material.dart';
import '../models/ride_model.dart';
import '../models/driver_model.dart';
import '../services/ride_service.dart';

class RideProvider extends ChangeNotifier {
  final RideService _rideService = RideService();
  
  Ride? _currentRide;
  List<Ride> _rideHistory = [];
  List<Driver> _nearbyDrivers = [];
  bool _isLoading = false;
  String? _errorMessage;

  Ride? get currentRide => _currentRide;
  List<Ride> get rideHistory => _rideHistory;
  List<Driver> get nearbyDrivers => _nearbyDrivers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Request a new ride
  Future<bool> requestRide(Ride ride) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentRide = await _rideService.createRide(ride);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Cancel ride
  Future<bool> cancelRide(String rideId, String reason) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _rideService.cancelRide(rideId, reason);
      _currentRide = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Accept ride (for drivers)
  Future<bool> acceptRide(String rideId, String driverId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentRide = await _rideService.acceptRide(rideId, driverId);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update ride status
  Future<bool> updateRideStatus(String rideId, String status) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentRide = await _rideService.updateRideStatus(rideId, status);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get ride history
  Future<void> loadRideHistory(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _rideHistory = await _rideService.getRideHistory(userId);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get nearby drivers
  Future<void> loadNearbyDrivers(double lat, double lng) async {
    try {
      _nearbyDrivers = await _rideService.getNearbyDrivers(lat, lng);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Calculate fare
  double calculateFare(double distance, int duration) {
    return _rideService.calculateFare(distance, duration);
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearCurrentRide() {
    _currentRide = null;
    notifyListeners();
  }
}
