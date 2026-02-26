import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';

class SupportManagementScreen extends StatelessWidget {
  const SupportManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final openCount =
        MockData.tickets.where((t) => t.status != 'resolved').length;
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
                    'Support Helpdesk',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage user inquiries and technical issues',
                    style: TextStyle(color: AppColors.slate500),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Avg Response Time',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.slate400,
                        ),
                      ),
                      const Text(
                        '2h 15m',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.emerald500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Open Tickets',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.slate400,
                        ),
                      ),
                      Text(
                        '$openCount',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.indigo500,
                        ),
                      ),
                    ],
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
                DataColumn(label: Text('Ticket')),
                DataColumn(label: Text('User')),
                DataColumn(label: Text('Priority')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Action')),
              ],
              rows: MockData.tickets.map((ticket) {
                return DataRow(
                  cells: [
                    DataCell(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ticket.subject,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700)),
                        Text('#${ticket.id}',
                            style: TextStyle(
                                fontSize: 10,
                                color: AppColors.slate400)),
                      ],
                    )),
                    DataCell(Text(ticket.user)),
                    DataCell(Chip(
                      label: Text(ticket.priority),
                      backgroundColor: ticket.priority == 'high'
                          ? AppColors.rose500.withValues(alpha: 0.1)
                          : ticket.priority == 'medium'
                              ? AppColors.amber500.withValues(alpha: 0.1)
                              : AppColors.slate100,
                    )),
                    DataCell(Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ticket.status == 'open'
                                ? Colors.blue
                                : ticket.status == 'pending'
                                    ? AppColors.amber500
                                    : AppColors.emerald500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(ticket.status),
                      ],
                    )),
                    DataCell(Text(ticket.date)),
                    DataCell(ElevatedButton(
                      onPressed: () {},
                      child: const Text('Reply'),
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
