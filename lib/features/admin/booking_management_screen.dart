import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class BookingManagementScreen extends StatefulWidget {
  const BookingManagementScreen({super.key});

  @override
  State<BookingManagementScreen> createState() => _BookingManagementScreenState();
}

class _BookingManagementScreenState extends State<BookingManagementScreen> {
  String _filter = 'all';
  late List<Booking> _bookings;

  @override
  void initState() {
    super.initState();
    _bookings = List.from(MockData.bookings);
  }

  void _markComplete(String id) {
    setState(() {
      final i = _bookings.indexWhere((b) => b.id == id);
      if (i >= 0) {
        _bookings[i] = _bookings[i].copyWith(status: 'completed');
      }
    });
  }

  List<Booking> get _filtered {
    if (_filter == 'all') return _bookings;
    if (_filter == 'active') {
      return _bookings
          .where((b) =>
              b.status == 'accepted' || b.status == 'in-progress')
          .toList();
    }
    return _bookings.where((b) => b.status == _filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Ledger',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Monitor live service lifecycle and fulfillment',
            style: TextStyle(color: AppColors.slate500),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            children: ['all', 'pending', 'active', 'completed', 'cancelled']
                .map((f) {
              final selected = _filter == f;
              return ChoiceChip(
                label: Text(f[0].toUpperCase() + f.substring(1)),
                selected: selected,
                onSelected: (_) => setState(() => _filter = f),
                selectedColor: AppColors.indigo500,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.slate500,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          if (_filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Column(
                  children: [
                    Icon(Icons.folder_open, size: 64, color: AppColors.slate400),
                    SizedBox(height: 16),
                    Text('No bookings found'),
                  ],
                ),
              ),
            )
          else
            ..._filtered.map((booking) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '#${booking.id}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.slate400,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Chip(
                                label: Text(booking.status),
                                backgroundColor: _statusColor(booking.status)
                                    .withValues(alpha: 0.1),
                              ),
                            ],
                          ),
                          Text(
                            '\$${booking.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: AppColors.slate900,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        booking.serviceName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person_outline, size: 14, color: AppColors.slate500),
                          const SizedBox(width: 4),
                          Text(booking.customerName, style: TextStyle(color: AppColors.slate500)),
                          const SizedBox(width: 16),
                          Icon(Icons.engineering, size: 14, color: AppColors.slate500),
                          const SizedBox(width: 4),
                          Text(booking.providerName, style: TextStyle(color: AppColors.slate500)),
                          const SizedBox(width: 16),
                          Icon(Icons.calendar_today, size: 14, color: AppColors.slate500),
                          const SizedBox(width: 4),
                          Text(booking.date, style: TextStyle(color: AppColors.slate500)),
                        ],
                      ),
                      if (booking.status == 'in-progress') ...[
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _markComplete(booking.id),
                          icon: const Icon(Icons.check),
                          label: const Text('Mark as Complete'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.emerald500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'completed':
        return AppColors.emerald500;
      case 'pending':
        return AppColors.amber500;
      case 'in-progress':
        return AppColors.indigo500;
      case 'cancelled':
        return AppColors.rose500;
      default:
        return AppColors.slate500;
    }
  }
}
