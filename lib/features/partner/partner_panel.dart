import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class PartnerPanel extends StatefulWidget {
  const PartnerPanel({
    super.key,
    required this.onAppModeChanged,
  });

  final ValueChanged<AppMode> onAppModeChanged;

  @override
  State<PartnerPanel> createState() => _PartnerPanelState();
}

class _PartnerPanelState extends State<PartnerPanel> {
  bool _isOnline = true;
  late List<Booking> _activeJobs;

  final _earningsData = [
    {'day': 'Mon', 'amount': 120.0},
    {'day': 'Tue', 'amount': 240.0},
    {'day': 'Wed', 'amount': 180.0},
    {'day': 'Thu', 'amount': 310.0},
    {'day': 'Fri', 'amount': 450.0},
    {'day': 'Sat', 'amount': 200.0},
    {'day': 'Sun', 'amount': 150.0},
  ];

  @override
  void initState() {
    super.initState();
    _activeJobs = MockData.bookings
        .where((b) => b.status != 'completed')
        .map((b) => Booking(
              id: b.id,
              customerName: b.customerName,
              providerName: b.providerName,
              serviceName: b.serviceName,
              date: b.date,
              amount: b.amount,
              status: b.status,
            ))
        .toList();
  }

  void _updateStatus(String id) {
    setState(() {
      _activeJobs = _activeJobs.map((job) {
        if (job.id != id) return job;
        final next = {
          'pending': 'accepted',
          'accepted': 'in-progress',
          'in-progress': 'completed',
        }[job.status];
        return job.copyWith(status: next ?? job.status);
      }).where((j) => j.status != 'completed').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F172A),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.epairRed,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.epairRed.withValues(alpha: 0.3),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.build_circle,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ePair Tech Hub',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              color: AppColors.slate500,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isOnline
                                      ? AppColors.emerald500
                                      : AppColors.slate600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _isOnline ? 'ONLINE' : 'OFFLINE',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () =>
                            widget.onAppModeChanged(AppMode.customer),
                        child: Text(
                          'Go to User App',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                            color: AppColors.slate400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () =>
                            setState(() => _isOnline = !_isOnline),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isOnline
                              ? AppColors.rose500.withValues(alpha: 0.2)
                              : AppColors.epairRed,
                          foregroundColor: _isOnline
                              ? AppColors.rose400
                              : Colors.white,
                        ),
                        child: Text(
                          _isOnline ? 'EXIT WORK' : 'START',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E293B),
                        border: Border.all(color: const Color(0xFF334155)),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WEEKLY REVENUE',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                              color: AppColors.slate500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '\$1,650.40',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            height: 160,
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: false),
                                titlesData: const FlTitlesData(show: false),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _earningsData
                                        .asMap()
                                        .entries
                                        .map((e) => FlSpot(
                                            e.key.toDouble(),
                                            (e.value['amount'] as num)
                                                .toDouble()))
                                        .toList(),
                                    isCurved: true,
                                    color: AppColors.epairRed,
                                    barWidth: 4,
                                    dotData: const FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: AppColors.epairRed
                                          .withValues(alpha: 0.2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'ACTIVE TASKS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: AppColors.slate500,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ..._activeJobs.map((job) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B).withValues(alpha: 0.5),
                          border: Border.all(color: const Color(0xFF334155)),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    job.serviceName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${job.amount.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.emerald500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () => _updateStatus(job.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.epairRed,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                ),
                                child: Text(
                                  job.status == 'pending'
                                      ? 'Accept'
                                      : 'Update Status',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
