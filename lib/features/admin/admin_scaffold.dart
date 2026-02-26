import 'package:flutter/material.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';
import 'admin_sidebar.dart';
import 'admin_header.dart';
import 'dashboard_screen.dart';
import 'user_management_screen.dart';
import 'service_management_screen.dart';
import 'booking_management_screen.dart';
import 'analytics_screen.dart';
import 'reviews_management_screen.dart';
import 'promotions_management_screen.dart';
import 'support_management_screen.dart';
import 'payments_management_screen.dart';
import 'settings_management_screen.dart';

class AdminScaffold extends StatefulWidget {
  const AdminScaffold({
    super.key,
    required this.onReturnToCustomer,
  });

  final VoidCallback onReturnToCustomer;

  @override
  State<AdminScaffold> createState() => _AdminScaffoldState();
}

class _AdminScaffoldState extends State<AdminScaffold> {
  AppView _currentView = AppView.dashboard;
  bool _sidebarOpen = true;

  Widget _buildContent() {
    switch (_currentView) {
      case AppView.dashboard:
        return const DashboardScreen();
      case AppView.users:
        return const UserManagementScreen(type: 'customer');
      case AppView.providers:
        return const UserManagementScreen(type: 'provider');
      case AppView.services:
        return const ServiceManagementScreen();
      case AppView.bookings:
        return const BookingManagementScreen();
      case AppView.analytics:
        return const AnalyticsScreen();
      case AppView.reviews:
        return const ReviewsManagementScreen();
      case AppView.promotions:
        return const PromotionsManagementScreen();
      case AppView.support:
        return const SupportManagementScreen();
      case AppView.payments:
        return const PaymentsManagementScreen();
      case AppView.settings:
        return const SettingsManagementScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AdminSidebar(
          currentView: _currentView,
          onViewChange: (v) => setState(() => _currentView = v),
          isOpen: _sidebarOpen,
          toggleSidebar: () => setState(() => _sidebarOpen = !_sidebarOpen),
        ),
        Expanded(
          child: Column(
            children: [
              AdminHeader(
                onToggleSidebar: () =>
                    setState(() => _sidebarOpen = !_sidebarOpen),
              ),
              Expanded(
                child: Container(
                  color: AppColors.slate50,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: widget.onReturnToCustomer,
                            child: const Text(
                              'Return to Customer View',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                                color: AppColors.epairRed,
                              ),
                            ),
                          ),
                        ),
                        _buildContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
