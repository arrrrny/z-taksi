class Ride {
  final String id;
  final String passengerId;
  final String? driverId;
  final String pickupAddress;
  final double pickupLat;
  final double pickupLng;
  final String destinationAddress;
  final double destinationLat;
  final double destinationLng;
  final String status; // requested, accepted, picked_up, completed, cancelled
  final double? fare;
  final double? distance; // in kilometers
  final DateTime requestedAt;
  final DateTime? acceptedAt;
  final DateTime? pickedUpAt;
  final DateTime? completedAt;
  final String? cancellationReason;

  Ride({
    required this.id,
    required this.passengerId,
    this.driverId,
    required this.pickupAddress,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationAddress,
    required this.destinationLat,
    required this.destinationLng,
    required this.status,
    this.fare,
    this.distance,
    required this.requestedAt,
    this.acceptedAt,
    this.pickedUpAt,
    this.completedAt,
    this.cancellationReason,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'passengerId': passengerId,
      'driverId': driverId,
      'pickupAddress': pickupAddress,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'destinationAddress': destinationAddress,
      'destinationLat': destinationLat,
      'destinationLng': destinationLng,
      'status': status,
      'fare': fare,
      'distance': distance,
      'requestedAt': requestedAt.toIso8601String(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'pickedUpAt': pickedUpAt?.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'cancellationReason': cancellationReason,
    };
  }

  factory Ride.fromMap(Map<String, dynamic> map) {
    return Ride(
      id: map['id'] ?? '',
      passengerId: map['passengerId'] ?? '',
      driverId: map['driverId'],
      pickupAddress: map['pickupAddress'] ?? '',
      pickupLat: (map['pickupLat'] ?? 0.0).toDouble(),
      pickupLng: (map['pickupLng'] ?? 0.0).toDouble(),
      destinationAddress: map['destinationAddress'] ?? '',
      destinationLat: (map['destinationLat'] ?? 0.0).toDouble(),
      destinationLng: (map['destinationLng'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'requested',
      fare: map['fare']?.toDouble(),
      distance: map['distance']?.toDouble(),
      requestedAt: map['requestedAt'] != null
          ? DateTime.parse(map['requestedAt'])
          : DateTime.now(),
      acceptedAt: map['acceptedAt'] != null
          ? DateTime.parse(map['acceptedAt'])
          : null,
      pickedUpAt: map['pickedUpAt'] != null
          ? DateTime.parse(map['pickedUpAt'])
          : null,
      completedAt: map['completedAt'] != null
          ? DateTime.parse(map['completedAt'])
          : null,
      cancellationReason: map['cancellationReason'],
    );
  }

  Ride copyWith({
    String? id,
    String? passengerId,
    String? driverId,
    String? pickupAddress,
    double? pickupLat,
    double? pickupLng,
    String? destinationAddress,
    double? destinationLat,
    double? destinationLng,
    String? status,
    double? fare,
    double? distance,
    DateTime? requestedAt,
    DateTime? acceptedAt,
    DateTime? pickedUpAt,
    DateTime? completedAt,
    String? cancellationReason,
  }) {
    return Ride(
      id: id ?? this.id,
      passengerId: passengerId ?? this.passengerId,
      driverId: driverId ?? this.driverId,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      pickupLat: pickupLat ?? this.pickupLat,
      pickupLng: pickupLng ?? this.pickupLng,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      destinationLat: destinationLat ?? this.destinationLat,
      destinationLng: destinationLng ?? this.destinationLng,
      status: status ?? this.status,
      fare: fare ?? this.fare,
      distance: distance ?? this.distance,
      requestedAt: requestedAt ?? this.requestedAt,
      acceptedAt: acceptedAt ?? this.acceptedAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      completedAt: completedAt ?? this.completedAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
    );
  }
}
