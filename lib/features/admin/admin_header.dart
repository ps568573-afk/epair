import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({
    super.key,
    required this.onToggleSidebar,
  });

  final VoidCallback onToggleSidebar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        border: Border(bottom: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onToggleSidebar,
            icon: const Icon(Icons.menu),
            style: IconButton.styleFrom(
              backgroundColor: AppColors.slate100,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppColors.slate400, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Search records...',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.slate700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {},
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none, color: AppColors.slate500),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.epairRed,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.slate500),
          ),
          const SizedBox(width: 8),
          Text(
            'English',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.slate700,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.slate400, size: 20),
        ],
      ),
    );
  }
}
