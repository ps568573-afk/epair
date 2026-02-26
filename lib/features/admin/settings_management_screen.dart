import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SettingsManagementScreen extends StatefulWidget {
  const SettingsManagementScreen({super.key});

  @override
  State<SettingsManagementScreen> createState() =>
      _SettingsManagementScreenState();
}

class _SettingsManagementScreenState extends State<SettingsManagementScreen> {
  String _section = 'general';

  @override
  Widget build(BuildContext context) {
    final sections = [
      ('general', 'General Brand', Icons.business),
      ('operations', 'Service Operations', Icons.build_circle),
      ('security', 'Security & Access', Icons.security),
      ('integrations', 'API & Integrations', Icons.power),
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Configuration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.slate900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Control platform global variables and operational logic',
            style: TextStyle(color: AppColors.slate500),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 256,
                child: Column(
                  children: sections.map((s) {
                    final (id, label, icon) = s;
                    final selected = _section == id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ListTile(
                        leading: Icon(icon),
                        title: Text(
                          label,
                          style: TextStyle(
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500,
                            color: selected
                                ? Colors.white
                                : AppColors.slate500,
                          ),
                        ),
                        tileColor: selected
                            ? AppColors.epairNavy
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onTap: () => setState(() => _section = id),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.slate100),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: _section == 'general'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Platform Name'),
                            const SizedBox(height: 8),
                            const TextField(
                              decoration: InputDecoration(
                                hintText: 'ePair Global',
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text('Contact Email'),
                            const SizedBox(height: 8),
                            const TextField(
                              decoration: InputDecoration(
                                hintText: 'hq@epair.io',
                              ),
                            ),
                            const SizedBox(height: 24),
                            const Text('Branding Colors'),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                _ColorChip('#c41e24'),
                                const SizedBox(width: 16),
                                _ColorChip('#0f1740'),
                                const SizedBox(width: 16),
                                _ColorChip('#ffd600'),
                              ],
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Update Brand'),
                            ),
                          ],
                        )
                      : _section == 'operations'
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Maintenance Mode',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Take the whole platform offline for scheduled updates',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.slate500),
                                ),
                                const SizedBox(height: 8),
                                Switch(value: false, onChanged: (_) {}),
                                const SizedBox(height: 24),
                                const Text('Global Commission Rate'),
                                Slider(value: 0.15, onChanged: (_) {}),
                                const Text('15%',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.indigo500)),
                                const SizedBox(height: 24),
                                const Text('Service Operating Hours'),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Weekdays',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors.slate400),
                                              ),
                                              const Text(
                                                '08:00 AM - 10:00 PM',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700),
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
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Weekends',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: AppColors.slate400),
                                              ),
                                              const Text(
                                                '10:00 AM - 06:00 PM',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : _section == 'integrations'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: AppColors.indigo500.withValues(alpha: 0.1),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: AppColors.indigo500,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.key,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Gemini AI API Key',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w900,
                                                      color: AppColors.epairNavy,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    'Required for diagnostic engines and business insights.',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.indigo600,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 12),
                                                  const TextField(
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      hintText: '*************************',
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  OutlinedButton(
                                                    onPressed: () {},
                                                    child: const Text('Revoke'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    const Text('Webhook Endpoints'),
                                    const SizedBox(height: 8),
                                    Card(
                                      child: ListTile(
                                        title: const Text(
                                          'https://api.analytics.io/v1/epair-hook',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        trailing: Chip(
                                          label: const Text('Live'),
                                          backgroundColor: AppColors.emerald500
                                              .withValues(alpha: 0.1),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip(this.hex);

  final String hex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Color(0xFF000000 | int.parse(hex.substring(1), radix: 16)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(width: 12),
        Text(hex, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
