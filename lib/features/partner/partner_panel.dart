import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';
import 'technician_dashboard.dart';

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
        .toList();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 900) {
      return Container(
        color: const Color(0xFF0F172A),
        child: SafeArea(
          child: Row(
            children: [
              _buildProfilePanel(),
              Expanded(child: _buildDashboard(isMobile: false)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      drawer: Drawer(
        backgroundColor: const Color(0xFF111827),
        child: SafeArea(child: _buildProfilePanel()),
      ),
      body: SafeArea(
        child: _buildDashboard(isMobile: true),
      ),
    );
  }

  // ============================================================
  // PROFILE PANEL
  // ============================================================

  Widget _buildProfilePanel() {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF111827),
        border: Border(
          right: BorderSide(color: Color(0xFF1F2937)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),

          const CircleAvatar(
            radius: 48,
            backgroundImage:
            NetworkImage('https://i.pravatar.cc/150?img=3'),
          ),

          const SizedBox(height: 16),

          const Text(
            "Rahul Sharma",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "AC Technician",
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 12,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 30),

          _profileStat("Rating", "4.8 ⭐"),
          _profileStat("Jobs Done", "126"),
          _profileStat("Experience", "3 Years"),

          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TechnicianDashboard(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.epairRed,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: const Text("View Requests"),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade800,
              minimumSize: const Size(double.infinity, 45),
            ),
            child: const Text("Edit Profile"),
          ),
        ],
      ),
    );
  }

  Widget _profileStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DASHBOARD
  // ============================================================

  Widget _buildDashboard({required bool isMobile}) {
    return Column(
      children: [
        _buildHeader(isMobile),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRevenueCard(),
                const SizedBox(height: 40),
                _buildActiveJobs(),
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),

          const Text(
            "Technician Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          ElevatedButton(
            onPressed: () =>
                setState(() => _isOnline = !_isOnline),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.epairRed,
            ),
            child: Text(_isOnline ? "Go Offline" : "Go Online"),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "WEEKLY REVENUE",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "₹1,650",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
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
                          .toDouble(),
                    ))
                        .toList(),
                    isCurved: true,
                    color: AppColors.epairRed,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ACTIVE JOBS",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        ..._activeJobs.take(3).map((job) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  job.serviceName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "₹${job.amount}",
                  style: TextStyle(
                    color: AppColors.emerald500,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}