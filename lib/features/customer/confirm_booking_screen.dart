import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({
    super.key,
    required this.service,
    required this.onConfirmed,
    required this.onBack,
  });

  final Service service;
  final VoidCallback onConfirmed;
  final VoidCallback onBack;

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  String? _selectedDate;
  String? _selectedTime;
  bool _isSuccess = false;

  static const _dates = [
    'Mon, 24 Jan',
    'Tue, 25 Jan',
    'Wed, 26 Jan',
    'Thu, 27 Jan',
  ];
  static const _times = [
    '09:00 AM',
    '11:30 AM',
    '02:00 PM',
    '04:30 PM',
  ];

  static IconData _iconForCategory(String iconName) {
    switch (iconName) {
      case 'smartphone':
        return Icons.smartphone;
      case 'laptop':
        return Icons.laptop;
      case 'sports_esports':
        return Icons.sports_esports;
      case 'electrical_services':
        return Icons.electrical_services;
      default:
        return Icons.build;
    }
  }

  void _confirm() {
    setState(() => _isSuccess = true);
  }

  @override
  Widget build(BuildContext context) {
    final category = MockData.categories
        .cast<Category?>()
        .firstWhere(
          (c) => c?.id == widget.service.categoryId,
          orElse: () => null,
        );

    if (_isSuccess) {
      return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.emerald500,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emerald500.withValues(alpha: 0.3),
                    blurRadius: 24,
                  ),
                ],
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 32),
            const Text(
              'Repair confirmed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: AppColors.epairNavy,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Set for $_selectedDate at $_selectedTime.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.slate500,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onConfirmed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.epairNavy,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Track Status'),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text(
              'Confirm Repair',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.epairNavy,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      border: Border.all(color: AppColors.slate100),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Icon(
                            _iconForCategory(category?.icon ?? ''),
                            color: AppColors.epairRed,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.service.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.epairNavy,
                                ),
                              ),
                              Text(
                                '\$${widget.service.basePrice.toInt()}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.epairRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'SELECT DATE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: AppColors.slate400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _dates.map((date) {
                      final isSelected = _selectedDate == date;
                      return ChoiceChip(
                        label: Text(date),
                        selected: isSelected,
                        onSelected: (_) =>
                            setState(() => _selectedDate = date),
                        selectedColor: AppColors.epairRed,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.slate500,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'SELECT TIME',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: AppColors.slate400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _times.map((time) {
                      final isSelected = _selectedTime == time;
                      return ChoiceChip(
                        label: Text(time),
                        selected: isSelected,
                        onSelected: (_) =>
                            setState(() => _selectedTime = time),
                        selectedColor: AppColors.epairNavy,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : AppColors.slate500,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.epairYellow.withValues(alpha: 0.1),
                      border: Border.all(
                          color: AppColors.epairYellow.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.epairNavy,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Our technician will call 15 minutes prior to arrival.',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.epairNavy,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.slate100)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedDate != null && _selectedTime != null
                    ? _confirm
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.epairRed,
                  disabledBackgroundColor: AppColors.slate200,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Confirm Appointment'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
