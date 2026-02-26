import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class PaymentsManagementScreen extends StatefulWidget {
  const PaymentsManagementScreen({super.key});

  @override
  State<PaymentsManagementScreen> createState() =>
      _PaymentsManagementScreenState();
}

class _PaymentsManagementScreenState extends State<PaymentsManagementScreen> {
  String _filter = 'all';

  List<Transaction> get _filtered {
    if (_filter == 'all') return MockData.transactions;
    return MockData.transactions
        .where((t) => t.status == _filter)
        .toList();
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
                    'Financial Ledger',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Track all incoming payments and technician payouts',
                    style: TextStyle(color: AppColors.slate500),
                  ),
                ],
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Monthly Statement'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Initiate Payouts'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NET REVENUE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: AppColors.slate400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '\$12,450.00',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.slate900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: const Text('+12.5%'),
                          backgroundColor: AppColors.emerald500.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TECHNICIAN PAYOUTS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: AppColors.slate400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '\$8,920.40',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.indigo500,
                          ),
                        ),
                        Text(
                          '72.4% of Gross',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors.slate400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REFUND RATE',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: AppColors.slate400,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '1.2%',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: AppColors.rose500,
                          ),
                        ),
                        Chip(
                          label: const Text('-0.4%'),
                          backgroundColor: AppColors.emerald500.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: ['all', 'succeeded', 'pending', 'failed']
                            .map((f) {
                          final selected = _filter == f;
                          return ChoiceChip(
                            label: Text(f),
                            selected: selected,
                            onSelected: (_) =>
                                setState(() => _filter = f),
                            selectedColor: AppColors.indigo500,
                            labelStyle: TextStyle(
                              color: selected
                                  ? Colors.white
                                  : AppColors.slate500,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search ID...',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Transaction Details')),
                      DataColumn(label: Text('Parties')),
                      DataColumn(label: Text('Amount')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Payout')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: _filtered.map((Transaction txn) {
                      return DataRow(
                        cells: [
                          DataCell(Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(txn.id,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                              Text(
                                '${txn.date} • ${txn.method}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: AppColors.slate400),
                              ),
                            ],
                          )),
                          DataCell(Row(
                            children: [
                              Text(txn.customer,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700)),
                              const Icon(Icons.arrow_forward, size: 12),
                              Text(txn.technician,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.slate500)),
                            ],
                          )),
                          DataCell(Text(
                            '\$${txn.amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w900),
                          )),
                          DataCell(Chip(
                            label: Text(txn.status),
                            backgroundColor: txn.status == 'succeeded'
                                ? AppColors.emerald500.withValues(alpha: 0.1)
                                : txn.status == 'pending'
                                    ? AppColors.amber500.withValues(alpha: 0.1)
                                    : txn.status == 'failed'
                                        ? AppColors.rose500.withValues(alpha: 0.1)
                                        : AppColors.slate100,
                          )),
                          DataCell(Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: txn.payoutStatus == 'paid'
                                      ? AppColors.emerald500
                                      : AppColors.amber500,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(txn.payoutStatus),
                            ],
                          )),
                          DataCell(IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          )),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
