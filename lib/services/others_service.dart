import 'dart:convert';
import './api_client.dart';

class OthersService {
  final ApiClient _api = ApiClient();

  Future<List<Map<String, dynamic>>> getOthers() async {
    final response = await _api.get('/others');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw jsonDecode(response.body)['message'] ?? 'Failed to fetch documents';
    }
  }

  Future<void> addOther(Map<String, dynamic> data) async {
    final response = await _api.post('/others', data);
    if (response.statusCode != 201) {
      throw jsonDecode(response.body)['message'] ?? 'Failed to add document';
    }
  }

  Future<void> updateOther(int id, Map<String, dynamic> data) async {
    final response = await _api.put('/others/$id', data);
    if (response.statusCode != 200) {
      throw jsonDecode(response.body)['message'] ?? 'Failed to update document';
    }
  }

  Future<void> deleteOther(int id) async {
    final response = await _api.delete('/others/$id');
    if (response.statusCode != 200) {
      throw jsonDecode(response.body)['message'] ?? 'Failed to delete document';
    }
  }
}
