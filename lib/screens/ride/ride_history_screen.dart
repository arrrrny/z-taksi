import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/ride_provider.dart';
import '../../providers/auth_provider.dart';

class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({super.key});

  @override
  State<RideHistoryScreen> createState() => _RideHistoryScreenState();
}

class _RideHistoryScreenState extends State<RideHistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadRideHistory();
  }

  Future<void> _loadRideHistory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final rideProvider = Provider.of<RideProvider>(context, listen: false);
    if (authProvider.currentUser != null) {
      await rideProvider.loadRideHistory(authProvider.currentUser!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final rideProvider = Provider.of<RideProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride History'),
      ),
      body: rideProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : rideProvider.rideHistory.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No ride history yet',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your completed rides will appear here',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadRideHistory,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: rideProvider.rideHistory.length,
                    itemBuilder: (context, index) {
                      final ride = rideProvider.rideHistory[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: _getStatusColor(ride.status).withOpacity(0.2),
                            child: Icon(
                              _getStatusIcon(ride.status),
                              color: _getStatusColor(ride.status),
                            ),
                          ),
                          title: Text(
                            ride.destinationAddress,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'From: ${ride.pickupAddress}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('MMM dd, yyyy - hh:mm a').format(ride.requestedAt),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (ride.fare != null)
                                Text(
                                  '\$${ride.fare!.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(ride.status).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  ride.status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _getStatusColor(ride.status),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            _showRideDetails(context, ride);
                          },
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'requested':
        return Colors.orange;
      case 'accepted':
      case 'picked_up':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'requested':
        return Icons.access_time;
      case 'accepted':
        return Icons.verified;
      case 'picked_up':
        return Icons.local_taxi;
      default:
        return Icons.help;
    }
  }

  void _showRideDetails(BuildContext context, ride) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ride Details',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _buildDetailRow('Pickup', ride.pickupAddress),
              const SizedBox(height: 12),
              _buildDetailRow('Destination', ride.destinationAddress),
              const SizedBox(height: 12),
              _buildDetailRow('Status', ride.status.toUpperCase()),
              const SizedBox(height: 12),
              _buildDetailRow(
                'Requested At',
                DateFormat('MMM dd, yyyy - hh:mm a').format(ride.requestedAt),
              ),
              if (ride.fare != null) ...[
                const SizedBox(height: 12),
                _buildDetailRow('Fare', '\$${ride.fare!.toStringAsFixed(2)}'),
              ],
              if (ride.distance != null) ...[
                const SizedBox(height: 12),
                _buildDetailRow('Distance', '${ride.distance!.toStringAsFixed(1)} km'),
              ],
              if (ride.completedAt != null) ...[
                const SizedBox(height: 12),
                _buildDetailRow(
                  'Completed At',
                  DateFormat('MMM dd, yyyy - hh:mm a').format(ride.completedAt!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
