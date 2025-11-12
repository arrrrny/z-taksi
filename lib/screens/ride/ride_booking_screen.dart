import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/ride_provider.dart';
import '../../providers/location_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/ride_model.dart';
import '../../utils/constants.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  final _pickupController = TextEditingController();
  final _destinationController = TextEditingController();
  double? _estimatedFare;
  double? _estimatedDistance;

  @override
  void initState() {
    super.initState();
    _initializePickupLocation();
  }

  Future<void> _initializePickupLocation() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    if (locationProvider.currentAddress != null) {
      _pickupController.text = locationProvider.currentAddress!;
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _calculateFare() {
    // Mock calculation - in production, use real distance calculation
    final distance = 5.0 + (DateTime.now().millisecond % 10); // Mock distance
    final duration = 15; // Mock duration in minutes
    
    final rideProvider = Provider.of<RideProvider>(context, listen: false);
    final fare = rideProvider.calculateFare(distance, duration);

    setState(() {
      _estimatedDistance = distance;
      _estimatedFare = fare;
    });
  }

  Future<void> _bookRide() async {
    if (_pickupController.text.isEmpty || _destinationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both pickup and destination'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    final rideProvider = Provider.of<RideProvider>(context, listen: false);

    final ride = Ride(
      id: const Uuid().v4(),
      passengerId: authProvider.currentUser!.id,
      pickupAddress: _pickupController.text,
      pickupLat: locationProvider.currentPosition?.latitude ?? AppConstants.defaultLatitude,
      pickupLng: locationProvider.currentPosition?.longitude ?? AppConstants.defaultLongitude,
      destinationAddress: _destinationController.text,
      destinationLat: AppConstants.defaultLatitude + 0.01,
      destinationLng: AppConstants.defaultLongitude + 0.01,
      status: AppConstants.rideStatusRequested,
      fare: _estimatedFare,
      distance: _estimatedDistance,
      requestedAt: DateTime.now(),
    );

    final success = await rideProvider.requestRide(ride);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ride requested successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(rideProvider.errorMessage ?? 'Failed to request ride'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final rideProvider = Provider.of<RideProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Ride'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Map preview placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.map,
                  size: 64,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _pickupController,
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                prefixIcon: const Icon(Icons.my_location, color: Colors.green),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // In production, open location search
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Destination',
                prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // In production, open location search
                  },
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _calculateFare();
                }
              },
            ),
            const SizedBox(height: 24),
            if (_estimatedFare != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Estimated Fare',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '\$${_estimatedFare!.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Distance'),
                          Text('${_estimatedDistance!.toStringAsFixed(1)} km'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Base Fare'),
                          Text('\$${AppConstants.baseFarePrice.toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
            ElevatedButton(
              onPressed: rideProvider.isLoading ? null : _bookRide,
              child: rideProvider.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}
