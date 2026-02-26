import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/theme/app_colors.dart';

class ReviewsManagementScreen extends StatelessWidget {
  const ReviewsManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Reviews',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Monitor and moderate service feedback',
            style: TextStyle(color: AppColors.slate500),
          ),
          const SizedBox(height: 24),
          ...MockData.reviews.map((review) {
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                review.customerName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.slate900,
                                ),
                              ),
                              const Text(' on ', style: TextStyle(color: AppColors.slate400)),
                              Text(
                                review.serviceName,
                                style: const TextStyle(
                                  color: AppColors.indigo500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                review.date,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.slate400,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < review.rating ? Icons.star : Icons.star_border,
                                size: 16,
                                color: AppColors.amber500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '"${review.comment}"',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.slate600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Provider: ${review.providerName}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.flag),
                          label: const Text('Flag'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.rose500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
