import '../models/ride_model.dart';
import '../models/driver_model.dart';
import '../utils/constants.dart';

class RideService {
  // Mock ride service
  // In production, this would use Firebase Firestore or similar

  final List<Ride> _rides = [];
  final List<Driver> _mockDrivers = [
    Driver(
      id: 'driver_1',
      userId: 'user_driver_1',
      vehicleModel: 'Toyota Camry',
      vehiclePlate: 'ABC123',
      vehicleColor: 'White',
      rating: 4.8,
      totalRides: 150,
      isAvailable: true,
      currentLat: 40.7128,
      currentLng: -74.0060,
    ),
    Driver(
      id: 'driver_2',
      userId: 'user_driver_2',
      vehicleModel: 'Honda Accord',
      vehiclePlate: 'XYZ789',
      vehicleColor: 'Black',
      rating: 4.9,
      totalRides: 200,
      isAvailable: true,
      currentLat: 40.7150,
      currentLng: -74.0080,
    ),
  ];

  // Create a new ride
  Future<Ride> createRide(Ride ride) async {
    await Future.delayed(const Duration(seconds: 1));
    _rides.add(ride);
    return ride;
  }

  // Cancel ride
  Future<void> cancelRide(String rideId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _rides.indexWhere((r) => r.id == rideId);
    if (index != -1) {
      _rides[index] = _rides[index].copyWith(
        status: AppConstants.rideStatusCancelled,
        cancellationReason: reason,
      );
    }
  }

  // Accept ride (for drivers)
  Future<Ride> acceptRide(String rideId, String driverId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _rides.indexWhere((r) => r.id == rideId);
    if (index != -1) {
      _rides[index] = _rides[index].copyWith(
        status: AppConstants.rideStatusAccepted,
        driverId: driverId,
        acceptedAt: DateTime.now(),
      );
      return _rides[index];
    }
    throw Exception('Ride not found');
  }

  // Update ride status
  Future<Ride> updateRideStatus(String rideId, String status) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _rides.indexWhere((r) => r.id == rideId);
    if (index != -1) {
      DateTime? statusTime;
      if (status == AppConstants.rideStatusPickedUp) {
        statusTime = DateTime.now();
        _rides[index] = _rides[index].copyWith(
          status: status,
          pickedUpAt: statusTime,
        );
      } else if (status == AppConstants.rideStatusCompleted) {
        statusTime = DateTime.now();
        _rides[index] = _rides[index].copyWith(
          status: status,
          completedAt: statusTime,
        );
      } else {
        _rides[index] = _rides[index].copyWith(status: status);
      }
      return _rides[index];
    }
    throw Exception('Ride not found');
  }

  // Get ride history
  Future<List<Ride>> getRideHistory(String userId) async {
    await Future.delayed(const Duration(seconds: 1));
    return _rides.where((r) => r.passengerId == userId).toList();
  }

  // Get nearby drivers
  Future<List<Driver>> getNearbyDrivers(double lat, double lng) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockDrivers.where((d) => d.isAvailable).toList();
  }

  // Calculate fare
  double calculateFare(double distance, int duration) {
    // Base fare + distance price + time price
    double fare = AppConstants.baseFarePrice +
        (distance * AppConstants.pricePerKm) +
        (duration * AppConstants.pricePerMinute);
    return double.parse(fare.toStringAsFixed(2));
  }

  // Get ride by ID
  Future<Ride?> getRideById(String rideId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _rides.firstWhere((r) => r.id == rideId);
    } catch (e) {
      return null;
    }
  }
}
