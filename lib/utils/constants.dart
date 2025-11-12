class AppConstants {
  // API Keys (Replace with actual keys)
  static const String googleMapsApiKey = 'YOUR_GOOGLE_MAPS_API_KEY';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String ridesCollection = 'rides';
  static const String driversCollection = 'drivers';
  
  // User Roles
  static const String rolePassenger = 'passenger';
  static const String roleDriver = 'driver';
  
  // Ride Status
  static const String rideStatusRequested = 'requested';
  static const String rideStatusAccepted = 'accepted';
  static const String rideStatusPickedUp = 'picked_up';
  static const String rideStatusCompleted = 'completed';
  static const String rideStatusCancelled = 'cancelled';
  
  // Default Values
  static const double defaultLatitude = 40.7128;
  static const double defaultLongitude = -74.0060;
  static const double baseFarePrice = 2.50;
  static const double pricePerKm = 1.50;
  static const double pricePerMinute = 0.30;
}
