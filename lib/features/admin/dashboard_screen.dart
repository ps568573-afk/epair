import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/gemini_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _insights = 'Analyzing your business data...';
  bool _loadingInsights = true;

  final _stats = (
    totalRevenue: 54300,
    activeUsers: 1240,
    totalBookings: 842,
    growthRate: 12.5,
  );

  @override
  void initState() {
    super.initState();
    _fetchInsights();
  }

  Future<void> _fetchInsights() async {
    final res = await GeminiService.getSmartInsights(
      totalRevenue: _stats.totalRevenue,
      activeUsers: _stats.activeUsers,
      totalBookings: _stats.totalBookings,
      growthRate: _stats.growthRate,
    );
    if (mounted) {
      setState(() {
        _insights = res;
        _loadingInsights = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Executive Overview',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Welcome back, admin. Here's what's happening today.",
                    style: TextStyle(color: AppColors.slate500),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download),
                    label: const Text('Export'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: const Text('New Service'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              _StatCard(
                title: 'Total Revenue',
                value: '\$${_stats.totalRevenue}',
                trend: 14.2,
                icon: Icons.attach_money,
                color: AppColors.indigo500,
              ),
              const SizedBox(width: 16),
              _StatCard(
                title: 'Active Users',
                value: '${_stats.activeUsers}',
                trend: 5.1,
                icon: Icons.people,
                color: Colors.blue,
              ),
              const SizedBox(width: 16),
              _StatCard(
                title: 'New Bookings',
                value: '${_stats.totalBookings}',
                trend: -2.4,
                icon: Icons.shopping_bag,
                color: AppColors.amber500,
              ),
              const SizedBox(width: 16),
              _StatCard(
                title: 'Completion Rate',
                value: '94.8%',
                trend: 3.8,
                icon: Icons.check_circle,
                color: AppColors.emerald500,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.slate100),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Revenue Performance',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.slate900,
                            ),
                          ),
                          DropdownButton<String>(
                            value: 'Last 7 Days',
                            items: const [
                              DropdownMenuItem(
                                  value: 'Last 7 Days', child: Text('Last 7 Days')),
                              DropdownMenuItem(
                                  value: 'Last 30 Days', child: Text('Last 30 Days')),
                            ],
                            onChanged: (_) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 300,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (value) =>
                                  FlLine(color: AppColors.slate100, strokeWidth: 1),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (v, _) => Text(
                                    v.toInt().toString(),
                                    style: TextStyle(
                                      color: AppColors.slate500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (v, _) {
                                    final i = v.toInt();
                                    if (i >= 0 &&
                                        i < MockData.revenueData.length) {
                                      return Text(
                                        MockData.revenueData[i].name,
                                        style: TextStyle(
                                          color: AppColors.slate500,
                                          fontSize: 12,
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                              topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: MockData.revenueData
                                    .asMap()
                                    .entries
                                    .map((e) => FlSpot(
                                        e.key.toDouble(),
                                        e.value.revenue))
                                    .toList(),
                                isCurved: true,
                                color: AppColors.indigo500,
                                barWidth: 3,
                                dotData: const FlDotData(show: false),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: AppColors.indigo500
                                      .withValues(alpha: 0.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF312E81),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.indigo500.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.indigoAccent,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'AI Business Insights',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 280,
                        child: _loadingInsights
                            ? const Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                        color: Colors.white54),
                                    SizedBox(height: 16),
                                    Text(
                                      'Processing metrics...',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              )
                            : SingleChildScrollView(
                                child: Text(
                                  _insights,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white24),
                          ),
                          child: const Text('Generate Detailed Report'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.slate100),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Top Services',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
                      ),
                      SizedBox(height: 16),
                      _TopServiceRow(name: 'Home Cleaning', orders: 423, growth: 12),
                      _TopServiceRow(name: 'Electric Repairs', orders: 254, growth: 8),
                      _TopServiceRow(name: 'Plumbing', orders: 198, growth: -3),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.slate100),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Bookings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.slate900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      DataTable(
                        columns: const [
                          DataColumn(label: Text('Customer')),
                          DataColumn(label: Text('Service')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: [
                          _bookingRow('User 1', 'Deep Cleaning', 'Pending', '\$45.00'),
                          _bookingRow('User 2', 'Deep Cleaning', 'Pending', '\$45.00'),
                          _bookingRow('User 3', 'Deep Cleaning', 'Pending', '\$45.00'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static DataRow _bookingRow(
      String customer, String service, String status, String amount) {
    return DataRow(
      cells: [
        DataCell(Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.indigo500.withValues(alpha: 0.2),
              child: Text(
                customer.split(' ').map((e) => e[0]).join(),
                style: const TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.indigo500),
              ),
            ),
            const SizedBox(width: 8),
            Text(customer),
          ],
        )),
        DataCell(Text(service)),
        DataCell(Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.amber500.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(status, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
        )),
        DataCell(Text(amount, style: const TextStyle(fontWeight: FontWeight.w600))),
        DataCell(IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz),
        )),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final double trend;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.slate100),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: trend > 0
                        ? AppColors.emerald500.withValues(alpha: 0.1)
                        : AppColors.rose500.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${trend > 0 ? '+' : ''}${trend.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: trend > 0 ? AppColors.emerald600 : AppColors.rose500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.slate500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.slate900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopServiceRow extends StatelessWidget {
  const _TopServiceRow({
    required this.name,
    required this.orders,
    required this.growth,
  });

  final String name;
  final int orders;
  final int growth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.slate100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '${orders % 10}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text('$orders orders', style: TextStyle(fontSize: 12, color: AppColors.slate400)),
                ],
              ),
            ],
          ),
          Text(
            '${growth > 0 ? '↑' : '↓'} ${growth.abs()}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: growth > 0 ? AppColors.emerald500 : AppColors.rose500,
            ),
          ),
        ],
      ),
    );
  }
}
