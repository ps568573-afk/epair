import 'package:flutter/material.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({
    super.key,
    required this.currentView,
    required this.onViewChange,
    required this.isOpen,
    required this.toggleSidebar,
  });

  final AppView currentView;
  final ValueChanged<AppView> onViewChange;
  final bool isOpen;
  final VoidCallback toggleSidebar;

  static const _menuItems = [
    (AppView.dashboard, 'Dashboard', Icons.pie_chart),
    (AppView.users, 'Customers', Icons.people),
    (AppView.providers, 'Technicians', Icons.engineering),
    (AppView.services, 'Repair Catalog', Icons.build),
    (AppView.bookings, 'Active Repairs', Icons.calendar_today),
    (AppView.payments, 'Financials', Icons.credit_card),
    (AppView.reviews, 'Feedback', Icons.star),
    (AppView.promotions, 'Campaigns', Icons.local_offer),
    (AppView.support, 'Helpdesk', Icons.headset_mic),
    (AppView.analytics, 'Business BI', Icons.show_chart),
    (AppView.settings, 'Settings', Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isOpen ? 256 : 0,
      child: isOpen
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: BorderSide(color: AppColors.slate200),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.epairRed,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.epairRed.withValues(alpha: 0.2),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.bolt,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'ePair ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: AppColors.epairNavy,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.epairRed,
                          ),
                        ),
                        IconButton(
                          onPressed: toggleSidebar,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: _menuItems.map((e) {
                        final (view, label, icon) = e;
                        final selected = currentView == view;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => onViewChange(view),
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.epairNavy
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: selected
                                      ? [
                                          BoxShadow(
                                            color: AppColors.epairNavy
                                                .withValues(alpha: 0.2),
                                            blurRadius: 16,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      icon,
                                      size: 20,
                                      color: selected
                                          ? AppColors.epairYellow
                                          : AppColors.slate600,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      label,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: selected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: selected
                                            ? Colors.white
                                            : AppColors.slate600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.slate100),
                      ),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/seed/admin/40/40'),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Super Admin',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.epairNavy,
                                ),
                              ),
                              Text(
                                'ePair HQ',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate400,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
