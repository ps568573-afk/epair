import 'api_service.dart';

class RepairService {
  // Submit repair request
  static Future<Map<String, dynamic>> createRequest(Map<String, dynamic> requestData) async {
    return await ApiService.post('/requests', requestData);
  }

  // Get my requests
  static Future<Map<String, dynamic>> getRequests({String? status, int page = 1}) async {
    String query = '?page=$page';
    if (status != null) query += '&status=$status';
    return await ApiService.get('/requests$query');
  }

  // Get single request
  static Future<Map<String, dynamic>> getRequest(String id) async {
    return await ApiService.get('/requests/$id');
  }

  // Cancel request
  static Future<Map<String, dynamic>> cancelRequest(String id, String reason) async {
    return await ApiService.put('/requests/$id/cancel', {'reason': reason});
  }

  // Submit review
  static Future<Map<String, dynamic>> submitReview(String id, int rating, String comment) async {
    return await ApiService.post('/requests/$id/review', {
      'rating': rating,
      'comment': comment,
    });
  }
}