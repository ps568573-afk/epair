import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class TechnicianDashboard extends StatefulWidget {
  const TechnicianDashboard({super.key});

  @override
  State<TechnicianDashboard> createState() =>
      _TechnicianDashboardState();
}

class _TechnicianDashboardState
    extends State<TechnicianDashboard> {

  late List<Booking> _requests;

  @override
  void initState() {
    super.initState();
    _requests = MockData.bookings;
  }

  void _updateStatus(String id, String newStatus) {
    setState(() {
      _requests = _requests.map((booking) {
        if (booking.id == id) {
          return booking.copyWith(status: newStatus);
        }
        return booking;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        title: const Text(
          "Customer Requests",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          final booking = _requests[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                // Service Name
                Text(
                  booking.serviceName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Customer: ${booking.customerName}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "Amount: ₹${booking.amount}",
                  style: TextStyle(
                    color: AppColors.emerald500,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Status: ${booking.status}",
                  style: TextStyle(
                    color: booking.status == 'pending'
                        ? Colors.orange
                        : booking.status == 'accepted'
                        ? Colors.blue
                        : booking.status == 'completed'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),

                const SizedBox(height: 16),

                if (booking.status == 'pending')
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              _updateStatus(
                                  booking.id, 'accepted'),
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                            Colors.green,
                          ),
                          child: const Text("Accept"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              _updateStatus(
                                  booking.id, 'rejected'),
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                            Colors.red,
                          ),
                          child: const Text("Reject"),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}