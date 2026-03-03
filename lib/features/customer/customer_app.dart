import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';
import 'home_tab.dart';
import 'ai_diagnosis_tab.dart';
import 'bookings_tab.dart';
import 'history_tab.dart';
import 'profile_tab.dart';
import 'confirm_booking_screen.dart';

enum CustomerTab { home, aiDiagnosis, bookings, history, profile }

class CustomerApp extends StatefulWidget {
  const CustomerApp({
    super.key,
    required this.onAppModeChanged,
  });

  final ValueChanged<AppMode> onAppModeChanged;

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  CustomerTab _activeTab = CustomerTab.home;
  String? _selectedCategoryId;
  Service? _bookingService;
  int _activeRepairsCount = 0;

  @override
  void initState() {
    super.initState();
    _activeRepairsCount = MockData.bookings
        .where((b) => b.status != 'completed')
        .length;
  }

  void _closeBooking() {
    setState(() => _bookingService = null);
  }

  void _goToBookingsAndClose() {
    setState(() {
      _activeTab = CustomerTab.bookings;
      _bookingService = null;
    });
  }

  Widget _buildEPairLogo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.epairRed, width: 4),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          "pair",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: AppColors.epairNavy,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_bookingService != null) {
      return ConfirmBookingScreen(
        service: _bookingService!,
        onBack: _closeBooking,
        onConfirmed: _goToBookingsAndClose,
      );
    }

    return Scaffold(
      backgroundColor: AppColors.slate50,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER
            Container(
              color: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildEPairLogo(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_outlined),
                  ),
                ],
              ),
            ),

            /// BODY
            Expanded(
              child: Container(
                color: Colors.white,
                child: IndexedStack(
                  index: _activeTab.index,
                  children: [
                    HomeTab(
                      selectedCategoryId: _selectedCategoryId,
                      onCategorySelected: (id) =>
                          setState(() => _selectedCategoryId = id),
                      onFixNow: (s) =>
                          setState(() => _bookingService = s),
                    ),
                    AiDiagnosisTab(
                      onFindService: () =>
                          setState(() => _activeTab = CustomerTab.home),
                    ),
                    const BookingsTab(),
                    const HistoryTab(),
                    ProfileTab(
                      onPartnerMode: () =>
                          widget.onAppModeChanged(AppMode.partner),
                      onAdminMode: () =>
                          widget.onAppModeChanged(AppMode.admin),
                    ),
                  ],
                ),
              ),
            ),

            /// BOTTOM NAVIGATION
            Container(
              height: 88,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.slate100),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(CustomerTab.home, Icons.home, 'Home'),
                  _navItem(CustomerTab.aiDiagnosis,
                      Icons.auto_awesome, 'AI'),
                  _navItem(CustomerTab.bookings,
                      Icons.build, 'Booking',
                      showBadge: _activeRepairsCount > 0),
                  _navItem(CustomerTab.history,
                      Icons.history, 'History'),
                  _navItem(CustomerTab.profile,
                      Icons.person, 'Profile'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      CustomerTab tab,
      IconData icon,
      String label, {
        bool showBadge = false,
      }) {
    final isSelected = _activeTab == tab;

    return InkWell(
      onTap: () => setState(() => _activeTab = tab),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                icon,
                size: 24,
                color:
                isSelected ? AppColors.epairRed : AppColors.slate400,
              ),
              if (showBadge)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.epairYellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? AppColors.epairRed
                  : AppColors.slate400,
            ),
          ),
        ],
      ),
    );
  }
}