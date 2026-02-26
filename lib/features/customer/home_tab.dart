import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/models/models.dart';
import '../../../core/theme/app_colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
    required this.onFixNow,
  });

  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;
  final ValueChanged<Service> onFixNow;

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

  @override
  Widget build(BuildContext context) {
    final filteredServices = selectedCategoryId != null
        ? MockData.services
            .where((s) => s.categoryId == selectedCategoryId)
            .toList()
        : MockData.services.take(4).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search for 'iPhone fix'...",
              prefixIcon: const Icon(Icons.search, color: AppColors.slate400),
              filled: true,
              fillColor: AppColors.slate50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: AppColors.slate100),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Promo card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.epairNavy, AppColors.slate900],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.slate200.withValues(alpha: 0.5),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.epairYellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'FLASH OFFER',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: AppColors.epairNavy,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Free Diagnosis\nfor Laptops!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.epairRed,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      ),
                      child: const Text('Book Now'),
                    ),
                  ],
                ),
                Positioned(
                  right: -24,
                  bottom: -24,
                  child: Icon(
                    Icons.build_circle,
                    size: 140,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'SERVICE CATEGORIES',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.epairNavy,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: MockData.categories.map((cat) {
              final isSelected = selectedCategoryId == cat.id;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: InkWell(
                    onTap: () =>
                        onCategorySelected(isSelected ? null : cat.id),
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.epairRed
                                : AppColors.slate50,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.epairRed
                                  : AppColors.slate50,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            _iconForCategory(cat.icon),
                            size: 28,
                            color: isSelected
                                ? Colors.white
                                : AppColors.slate400,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          cat.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            color: AppColors.slate700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Text(
            'RECOMMENDED REPAIRS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.epairNavy,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          ...filteredServices.map((srv) {
            final cat = MockData.categories
                .cast<Category?>()
                .firstWhere(
                  (c) => c?.id == srv.categoryId,
                  orElse: () => null,
                );
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(20),
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
                      _iconForCategory(cat?.icon ?? ''),
                      color: AppColors.epairNavy,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          srv.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: AppColors.epairNavy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${srv.basePrice.toInt()}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: AppColors.epairRed,
                              ),
                            ),
                            TextButton(
                              onPressed: () => onFixNow(srv),
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.epairNavy,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                              ),
                              child: const Text(
                                'FIX NOW',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
