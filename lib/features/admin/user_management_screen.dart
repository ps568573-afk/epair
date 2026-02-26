import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({
    super.key,
    required this.type,
  });

  final String type; // 'customer' | 'provider'

  @override
  Widget build(BuildContext context) {
    final users =
        MockData.users.where((u) => u.role == type).toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${type[0].toUpperCase()}${type.substring(1)} Management',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate900,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 240,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search users...',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Add $type'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.slate100),
              borderRadius: BorderRadius.circular(16),
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('User Details')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Join Date')),
                DataColumn(label: Text('Total Bookings')),
                DataColumn(label: Text('Actions')),
              ],
              rows: users.map((user) {
                return DataRow(
                  cells: [
                    DataCell(Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/seed/john/100/100'),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600)),
                            Text(user.email,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.slate500)),
                          ],
                        ),
                      ],
                    )),
                    DataCell(Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: user.status == 'active'
                            ? AppColors.emerald500.withValues(alpha: 0.1)
                            : user.status == 'pending'
                                ? AppColors.amber500.withValues(alpha: 0.1)
                                : AppColors.slate100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.status,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: user.status == 'active'
                              ? AppColors.emerald600
                              : user.status == 'pending'
                                  ? AppColors.amber500
                                  : AppColors.slate500,
                        ),
                      ),
                    )),
                    DataCell(Text(user.joinedDate)),
                    DataCell(Text('${user.totalBookings}')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    )),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
