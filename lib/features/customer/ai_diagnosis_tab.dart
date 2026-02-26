import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../services/gemini_service.dart';

class AiDiagnosisTab extends StatefulWidget {
  const AiDiagnosisTab({super.key, required this.onFindService});

  final VoidCallback onFindService;

  @override
  State<AiDiagnosisTab> createState() => _AiDiagnosisTabState();
}

class _AiDiagnosisTabState extends State<AiDiagnosisTab> {
  final _symptomController = TextEditingController();
  String? _aiResult;
  bool _isLoading = false;

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }

  Future<void> _runDiagnosis() async {
    final text = _symptomController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _isLoading = true;
      _aiResult = null;
    });
    try {
      final result = await GeminiService.runAiDiagnosis(text);
      if (mounted) setState(() => _aiResult = result);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _reset() {
    _symptomController.clear();
    setState(() => _aiResult = null);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.epairNavy,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.epairNavy.withValues(alpha: 0.3),
                  blurRadius: 16,
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology,
              size: 40,
              color: AppColors.epairYellow,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ePair AI Insight',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: AppColors.epairNavy,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Describe the issue your device is having for an instant professional assessment.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.slate500,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _symptomController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText:
                  "e.g. My laptop keyboard isn't responding and the fan is making a loud buzzing noise...",
              filled: true,
              fillColor: AppColors.slate50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: AppColors.slate100),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isLoading || _symptomController.text.trim().isEmpty
                      ? null
                      : _runDiagnosis,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.bolt),
                  label: Text(_isLoading ? 'Analyzing...' : 'Diagnose Issue'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.epairRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              if (_aiResult != null) ...[
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _reset,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.slate100,
                  ),
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ],
          ),
          if (_aiResult != null) ...[
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.slate100, width: 2),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.epairNavy,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.medical_services,
                          color: AppColors.epairYellow,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'DIAGNOSTIC REPORT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                          color: AppColors.epairNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ..._aiResult!
                      .split('###')
                      .where((s) => s.trim().isNotEmpty)
                      .map((section) {
                    final lines = section.trim().split('\n');
                    final title = lines.isNotEmpty ? lines.first : '';
                    final body =
                        lines.length > 1 ? lines.sublist(1).join('\n') : '';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.slate50.withValues(alpha: 0.5),
                        border: Border.all(
                            color: AppColors.slate100.withValues(alpha: 0.5)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: AppColors.epairNavy,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            body,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.slate600,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  const Divider(height: 1),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VERIFIED REPAIR QUALITY',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.slate400,
                            ),
                          ),
                          const Text(
                            'Certified Technicians Only',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: AppColors.epairNavy,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: widget.onFindService,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.epairNavy,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Find Nearby Service Center'),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
