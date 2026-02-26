import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    super.key,
    required this.onPartnerMode,
    required this.onAdminMode,
  });

  final VoidCallback onPartnerMode;
  final VoidCallback onAdminMode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          const CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(
                'https://picsum.photos/seed/user123/200/200'),
            backgroundColor: AppColors.slate100,
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColors.epairNavy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'PREMIUM CUSTOMER',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppColors.slate400,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.slate100),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 16,
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.settings, color: AppColors.slate400),
                  ),
                  title: const Text(
                    'Account Settings',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate700,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.slate50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.account_balance_wallet, color: AppColors.slate400),
                  ),
                  title: const Text(
                    'Payment Methods',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.slate700,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.slate400),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.epairNavy,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.epairNavy.withValues(alpha: 0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'INTERNAL ACCESS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: AppColors.epairYellow,
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.engineering, color: AppColors.epairYellow),
                  title: const Text(
                    'Technician Portal',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.3)),
                  onTap: onPartnerMode,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.admin_panel_settings, color: AppColors.epairRed),
                  title: const Text(
                    'Admin Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.3)),
                  onTap: onAdminMode,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.power_settings_new, color: AppColors.rose500, size: 20),
            label: const Text(
              'SIGN OUT',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                color: AppColors.rose500,
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
