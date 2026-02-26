import 'package:google_generative_ai/google_generative_ai.dart';

/// API key can be set via [GeminiService.apiKey] or environment.
class GeminiService {
  static String? apiKey;

  static String get _key => apiKey ?? '';

  static Future<String> getSmartInsights({
    required int totalRevenue,
    required int activeUsers,
    required int totalBookings,
    required double growthRate,
  }) async {
    try {
      if (_key.isEmpty) {
        return 'Insights unavailable. Set GeminiService.apiKey or API_KEY.';
      }
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _key,
      );
      final prompt = '''
Analyze the following business metrics for an on-demand service app and provide 3-4 concise, actionable executive insights in Markdown format.
Data:
- Total Revenue: \$$totalRevenue
- Active Users: $activeUsers
- Total Bookings: $totalBookings
- Growth Rate: $growthRate%

Focus on growth opportunities, churn risk, or service optimization. Keep it professional and high-level.
''';
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? 'Unable to generate insights at this time.';
    } catch (e) {
      return 'Insights unavailable. Please check your API configuration.';
    }
  }

  static Future<String> runAiDiagnosis(String symptom) async {
    try {
      if (_key.isEmpty) {
        return "Our AI diagnostic engine is currently undergoing maintenance. Please bring your device in for a manual inspection.";
      }
      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _key,
      );
      final prompt = '''
Act as a professional electronics repair expert for ePair. A customer described this device problem: "$symptom".
Provide a detailed report in a professional, empathetic tone.
The report must be structured as follows using clear Markdown headings:

### 🩺 Primary Diagnosis
A clear explanation of what is likely wrong.

### 🛠️ Professional Troubleshooting
3-5 specific steps the user can safely try at home to resolve or narrow down the issue.

### ⚠️ Common Causes
Why this issue typically occurs (e.g., hardware wear, software conflict, environmental factors).

### 💰 Estimated Repair Cost
A realistic price range for professional intervention.

Keep the language accessible but technical enough to show expertise. Use bullet points for steps.
''';
      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "I'm having trouble analyzing this. Please consult one of our technicians.";
    } catch (e) {
      return "Our AI diagnostic engine is currently undergoing maintenance. Please bring your device in for a manual inspection.";
    }
  }
}
