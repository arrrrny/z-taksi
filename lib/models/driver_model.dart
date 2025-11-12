class Driver {
  final String id;
  final String userId;
  final String vehicleModel;
  final String vehiclePlate;
  final String vehicleColor;
  final double rating;
  final int totalRides;
  final bool isAvailable;
  final double? currentLat;
  final double? currentLng;

  Driver({
    required this.id,
    required this.userId,
    required this.vehicleModel,
    required this.vehiclePlate,
    required this.vehicleColor,
    this.rating = 5.0,
    this.totalRides = 0,
    this.isAvailable = true,
    this.currentLat,
    this.currentLng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'vehicleModel': vehicleModel,
      'vehiclePlate': vehiclePlate,
      'vehicleColor': vehicleColor,
      'rating': rating,
      'totalRides': totalRides,
      'isAvailable': isAvailable,
      'currentLat': currentLat,
      'currentLng': currentLng,
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      vehicleModel: map['vehicleModel'] ?? '',
      vehiclePlate: map['vehiclePlate'] ?? '',
      vehicleColor: map['vehicleColor'] ?? '',
      rating: (map['rating'] ?? 5.0).toDouble(),
      totalRides: map['totalRides'] ?? 0,
      isAvailable: map['isAvailable'] ?? true,
      currentLat: map['currentLat']?.toDouble(),
      currentLng: map['currentLng']?.toDouble(),
    );
  }

  Driver copyWith({
    String? id,
    String? userId,
    String? vehicleModel,
    String? vehiclePlate,
    String? vehicleColor,
    double? rating,
    int? totalRides,
    bool? isAvailable,
    double? currentLat,
    double? currentLng,
  }) {
    return Driver(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      vehiclePlate: vehiclePlate ?? this.vehiclePlate,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      isAvailable: isAvailable ?? this.isAvailable,
      currentLat: currentLat ?? this.currentLat,
      currentLng: currentLng ?? this.currentLng,
    );
  }
}
