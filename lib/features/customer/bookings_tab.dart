import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final activeRepairs =
        MockData.bookings.where((b) => b.status != 'completed').toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active repairs',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.epairNavy,
            ),
          ),
          const SizedBox(height: 20),
          if (activeRepairs.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.slate50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.build,
                        size: 32,
                        color: AppColors.slate400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No active repairs at the moment.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.slate400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...activeRepairs.map((booking) {
              final isInProgress = booking.status == 'in-progress';
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.slate100),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.slate100.withValues(alpha: 0.5),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 8,
                        decoration: BoxDecoration(
                          color: isInProgress
                              ? AppColors.epairRed
                              : AppColors.epairYellow,
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(8)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    booking.date,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.epairRed,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    booking.serviceName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.epairNavy,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: booking.status == 'completed'
                                      ? AppColors.emerald500.withValues(alpha: 0.1)
                                      : AppColors.epairYellow.withValues(alpha: 0.1),
                                  border: Border.all(
                                    color: booking.status == 'completed'
                                        ? AppColors.emerald500
                                        : AppColors.epairYellow,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  booking.status.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                    color: booking.status == 'completed'
                                        ? AppColors.emerald600
                                        : AppColors.epairNavy,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.person_outline,
                                size: 14,
                                color: AppColors.epairNavy,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Assignee: ${booking.providerName}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
