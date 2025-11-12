import 'package:flutter_test/flutter_test.dart';
import 'package:z_taksi/models/user_model.dart';
import 'package:z_taksi/models/driver_model.dart';
import 'package:z_taksi/models/ride_model.dart';
import 'package:z_taksi/utils/constants.dart';

void main() {
  group('User Model Tests', () {
    test('User model should be created correctly', () {
      final user = User(
        id: 'test_user_1',
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        role: AppConstants.rolePassenger,
        createdAt: DateTime.now(),
      );

      expect(user.id, 'test_user_1');
      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.role, AppConstants.rolePassenger);
    });

    test('User model should convert to map correctly', () {
      final user = User(
        id: 'test_user_1',
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '+1234567890',
        role: AppConstants.rolePassenger,
        createdAt: DateTime.now(),
      );

      final map = user.toMap();

      expect(map['id'], 'test_user_1');
      expect(map['name'], 'John Doe');
      expect(map['email'], 'john@example.com');
      expect(map['role'], AppConstants.rolePassenger);
    });
  });

  group('Driver Model Tests', () {
    test('Driver model should be created correctly', () {
      final driver = Driver(
        id: 'driver_1',
        userId: 'user_1',
        vehicleModel: 'Toyota Camry',
        vehiclePlate: 'ABC123',
        vehicleColor: 'White',
        rating: 4.8,
        totalRides: 100,
        isAvailable: true,
      );

      expect(driver.id, 'driver_1');
      expect(driver.vehicleModel, 'Toyota Camry');
      expect(driver.rating, 4.8);
      expect(driver.isAvailable, true);
    });

    test('Driver model should convert to map correctly', () {
      final driver = Driver(
        id: 'driver_1',
        userId: 'user_1',
        vehicleModel: 'Toyota Camry',
        vehiclePlate: 'ABC123',
        vehicleColor: 'White',
      );

      final map = driver.toMap();

      expect(map['id'], 'driver_1');
      expect(map['vehicleModel'], 'Toyota Camry');
      expect(map['vehiclePlate'], 'ABC123');
    });
  });

  group('Ride Model Tests', () {
    test('Ride model should be created correctly', () {
      final ride = Ride(
        id: 'ride_1',
        passengerId: 'passenger_1',
        pickupAddress: '123 Main St',
        pickupLat: 40.7128,
        pickupLng: -74.0060,
        destinationAddress: '456 Park Ave',
        destinationLat: 40.7589,
        destinationLng: -73.9851,
        status: AppConstants.rideStatusRequested,
        requestedAt: DateTime.now(),
      );

      expect(ride.id, 'ride_1');
      expect(ride.passengerId, 'passenger_1');
      expect(ride.status, AppConstants.rideStatusRequested);
      expect(ride.pickupAddress, '123 Main St');
    });

    test('Ride model should convert to map correctly', () {
      final ride = Ride(
        id: 'ride_1',
        passengerId: 'passenger_1',
        pickupAddress: '123 Main St',
        pickupLat: 40.7128,
        pickupLng: -74.0060,
        destinationAddress: '456 Park Ave',
        destinationLat: 40.7589,
        destinationLng: -73.9851,
        status: AppConstants.rideStatusRequested,
        requestedAt: DateTime.now(),
      );

      final map = ride.toMap();

      expect(map['id'], 'ride_1');
      expect(map['passengerId'], 'passenger_1');
      expect(map['pickupAddress'], '123 Main St');
      expect(map['status'], AppConstants.rideStatusRequested);
    });

    test('Ride model should update status correctly', () {
      final ride = Ride(
        id: 'ride_1',
        passengerId: 'passenger_1',
        pickupAddress: '123 Main St',
        pickupLat: 40.7128,
        pickupLng: -74.0060,
        destinationAddress: '456 Park Ave',
        destinationLat: 40.7589,
        destinationLng: -73.9851,
        status: AppConstants.rideStatusRequested,
        requestedAt: DateTime.now(),
      );

      final updatedRide = ride.copyWith(
        status: AppConstants.rideStatusAccepted,
        driverId: 'driver_1',
      );

      expect(updatedRide.status, AppConstants.rideStatusAccepted);
      expect(updatedRide.driverId, 'driver_1');
      expect(updatedRide.id, ride.id); // Should maintain same ID
    });
  });
}
